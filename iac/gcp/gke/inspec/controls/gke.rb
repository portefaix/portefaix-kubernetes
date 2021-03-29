# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

project_id = attribute('project_id', description:'GCP project id')
location = attribute("location", description:'GCP location')
clustername = attribute("clustername", description:'The Kubernetes cluster name')


control 'gke-1' do
  impact 0.8

  title 'Stackdriver Logging and Monitoring is configured'

  tag platform: 'GCP'
  tag category: 'Logging / Monitoring'
  tag resource: 'GKE'
  tag effort: 0.2

  describe "#{project_id}/#{location}/#{clustername}:" do
    subject { google_container_cluster(project: project_id, location: location, name: clustername, beta: true) }
    its('logging_service') { should match /logging.googleapis.com\/kubernetes/ }
    its('monitoring_service') { should match /monitoring.googleapis.com\/kubernetes/ }
  end
end


control 'gke-2' do
  impact 1.0

  title 'Basic Authentication is disabled'

  tag platform: 'GCP'
  tag category: 'Identity and Access Management'
  tag resource: 'GKE'
  tag effort: 0.9

  describe "#{project_id}/#{location}/#{clustername}:" do
    subject { google_container_cluster(project: project_id, location: location, name: clustername, beta: true) }
    its('master_auth.username') { should cmp nil }
  end
end


control 'gke-3' do
  impact 0.5

  title 'Ensure GKE Nodes are not public'

  tag platform: 'GCP'
  tag category: 'Network Access Control'
  tag resource: 'GKE'
  tag effort: 0.9

  describe "#{project_id}/#{location}/#{clustername}:" do
    subject { google_container_cluster(project: project_id, location: location, name: clustername, beta: true) }
    its('private_cluster_config.enable_private_nodes') { should cmp true }
  end
end

control 'gke-4' do
  impact 1.0

  title 'Ensure the GKE Control Plane is not public'

  tag platform: 'GCP'
  tag category: 'Network Access Control'
  tag resource: 'GKE'
  tag effort: 0.2

  cluster = google_container_cluster(project: project_id, location: location, name: clustername, beta: true)
  describe.one do
    describe "#{project_id}/#{location}/#{clustername}:" do
      subject { cluster }
      its('private_cluster_config.enable_private_endpoint') { should cmp true }
      its('master_authorized_networks_config.cidr_blocks') { should_not be_empty }
    end
    describe "#{project_id}/#{location}/#{clustername}:" do
      subject { cluster }
      its('master_authorized_networks_config.cidr_blocks') { should_not be_empty }
      its('master_authorized_networks_config.cidr_blocks.to_s') { should_not match '[/0.0.0.0\/0/]' }
    end
  end
end

# control 'gke-5' do
#   impact 0.9

#   title 'Ensure the Network Policy managed addon is enabled'

#   tag platform: 'GCP'
#   tag category: 'Network Access Control'
#   tag resource: 'GKE'
#   tag effort: 0.5

#   describe "#{project_id}/#{location}/#{clustername}:" do
#     subject { google_container_cluster(project: project_id, location: location, name: clustername, beta: true) }
#     its('network_policy.enabled') { should cmp true }
#   end
# end

# control 'gke-6' do
#   impact 0.7

#   title 'Ensure OAuth Access Scopes and dedicated Service Accounts for node pools'

#   tag platform: 'GCP'
#   tag category: 'Identity and Access Management'
#   tag resource: 'GKE'
#   tag effort: 0.2

#   ref 'GKE OAuth Access Scopes', url: 'https://cloud.google.com/kubernetes-engine/docs/how-to/access-scopes'
#   ref 'GCP Service Account Permissions', url: 'https://cloud.google.com/compute/docs/access/service-accounts#service_account_permissions'
#   ref 'GCP Default Service Account', url: 'https://cloud.google.com/compute/docs/access/service-accounts#default_service_account'

#   google_container_node_pools(project: project_id, location: location, cluster_name: clustername).node_pool_names.each do |nodepool|
#     describe "#{project_id}/#{location}/#{clustername}/#{nodepool}:" do
#       subject { google_container_node_pool(project: project_id, location: location, cluster_name: clustername, nodepool_name: nodepool, beta: true) }
#       its('config.service_account') { should_not cmp 'default' }
#       its('config.oauth_scopes') { should_not include /cloud-platform/ }
#       its('config.oauth_scopes') { should_not include /compute/ }
#       its('config.oauth_scopes') { should_not include /compute-ro/ }
#       its('config.oauth_scopes') { should_not include /compute-rw/ }
#       its('config.oauth_scopes') { should_not include /container/ }
#       its('config.oauth_scopes') { should_not include /iam/ }
#       its('config.oauth_scopes') { should include /devstorage.read_only/ }
#       its('config.oauth_scopes') { should include /logging.write/ }
#       its('config.oauth_scopes') { should include /monitoring/ }
#       its('config.oauth_scopes') { should include /service.management.readonly/ }
#       its('config.oauth_scopes') { should include /servicecontrol/ }
#       its('config.oauth_scopes') { should include /trace.append/ }
#     end
#   end
# end

control 'gke-7' do
  impact 0.5

  title 'Ensure GKE Node Pools should use the COS or COS_CONTAINERD Operating System'

  tag platform: 'GCP'
  tag category: 'Host and Cluster Security'
  tag resource: 'GKE'
  tag effort: 0.9

  google_container_node_pools(project: project_id, location: location, cluster_name: clustername).node_pool_names.each do |nodepool|
    describe "#{project_id}/#{location}/#{clustername}/#{nodepool}:" do
      subject { google_container_node_pool(project: project_id, location: location, cluster_name: clustername, nodepool_name: nodepool, beta: true) }
      its('config.image_type') { should match /^COS.*/i }
    end
  end
end

# control 'gke-8' do
#   impact 0.9

#   title 'GKE Workload Identity should be enabled and enforcing metadata protection on all NodePools'

#   describe "#{project_id}/#{location}/#{clustername}:" do
#     subject { google_container_cluster(project: project_id, location: location, name: clustername, beta: true) }
#     it 'should have workload identity configured at the cluster level' do
#       expect(subject.fetched['workloadIdentityConfig']).not_to be nil
#       expect(subject.fetched['workloadIdentityConfig']['workloadPool']).not_to be nil
#     end
#   end

#   google_container_node_pools(project: project_id, location: location, cluster_name: clustername).node_pool_names.each do |nodepool|
#     describe "#{project_id}/#{location}/#{clustername}/#{nodepool}:" do
#       subject { google_container_node_pool(project: project_id, location: location, cluster_name: clustername, nodepool_name: nodepool, beta: true) }
#       it 'should have workload identity metadata server on the node pool' do
#         expect(subject.fetched['config']['workloadMetadataConfig']).not_to be nil
#         expect(subject.fetched['config']['workloadMetadataConfig']['mode']).not_to be nil
#         expect(subject.fetched['config']['workloadMetadataConfig']['mode']).to eq('GKE_METADATA')
#       end
#     end
#   end
# end

# control 'gke-9' do
#   impact 0.5

#   title 'GKE Shielded Nodes should be enabled on all NodePools'

#   tag platform: 'GCP'
#   tag category: 'Host and Cluster Security'
#   tag resource: 'GKE'
#   tag effort: 0.5

#   describe "#{project_id}/#{location}/#{clustername}:" do
#     subject { google_container_cluster(project: project_id, location: location, name: clustername, beta: true) }
#     it 'should have shielded nodes set at the cluster level' do
#       expect(subject.fetched['shieldedNodes']).not_to be nil
#       expect(subject.fetched['shieldedNodes']['enabled']).to eq(true)
#     end
#   end

#   google_container_node_pools(project: project_id, location: location, cluster_name: clustername).node_pool_names.each do |nodepool|
#     describe "#{project_id}/#{location}/#{clustername}/#{nodepool}:" do
#       subject { google_container_node_pool(project: project_id, location: location, cluster_name: clustername, nodepool_name: nodepool, beta: true) }
#       it 'should have workload identity metadata server on the node pool' do
#         expect(subject.fetched['config']['shieldedInstanceConfig']).not_to be nil
#         expect(subject.fetched['config']['shieldedInstanceConfig']['enableSecureBoot']).to eq(true)
#       end
#     end
#   end
# end


control 'gke-10' do
  impact 1.0

  title 'Ensure instances have labels'

  tag platform: 'GCP'
  tag category: 'Labels'
  tag resource: 'GCE'
  tag effort: 0.2

  google_compute_zones(project: project_id).where(zone_name: /^eu/).zone_names.each do |zone_name|
    google_compute_instances(project: project_id, zone: zone_name).where(instance_name: /^gke.*$/).instance_names.each do |instance_name|
      describe google_compute_instance(project: project_id, zone: zone_name, name: instance_name) do
        it { should exist }
        # its('name') { should match '#{CUSTOMER}' }
        its('labels.keys') { should include 'env' }
        its('labels.keys') { should include 'service' }
        its('labels.keys') { should include 'made-by' }
      end
    end
  end

end

control 'gke-11' do
  impact 1.0

  title 'Ensure instances have tags'

  tag platform: 'GCP'
  tag category: 'Tags'
  tag resource: 'GCE'
  tag effort: 0.2

  google_compute_zones(project: project_id).where(zone_name: /^eu/).zone_names.each do |zone_name|
    google_compute_instances(project: project_id, zone: zone_name).where(instance_name: /^gke.*$/).instance_names.each do |instance_name|
      describe google_compute_instance(project: project_id, zone: zone_name, name: instance_name) do
        it { should exist }
        its('tags.items') { should include 'kubernetes' }
      end
    end
  end

end
