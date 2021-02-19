# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

awsregion = attribute('awsregion')
clustername = attribute('clustername')

control 'eks-1' do
  impact 0.9
  title 'Ensure the AWS EKS Cluster is running a minimal version'

  tag platform: "AWS"
  tag category: "Management and Governance"
  tag resource: "EKS"
  tag effort: 0.5

  describe "#{awsregion}/#{clustername}: version" do
    subject { aws_eks_cluster(cluster_name: clustername, aws_region: awsregion)}
    its('major_version') { should be >= "1" }
    its('minor_version') { should be >= "16" }
  end
end

control 'eks-2' do
  impact 1.0
  title 'Ensure the AWS EKS Cluster control plane has audit logs enabled'

  tag platform: "AWS"
  tag category: "Management and Governance"
  tag resource: "EKS"
  tag effort: 0.2

  describe "#{awsregion}/#{clustername}: audit logs" do
    subject { aws_eks_cluster(cluster_name: clustername, aws_region: awsregion)}
    its('logs_enabled') { should cmp ["api", "audit", "authenticator", "controllerManager", "scheduler"] }
  end
end

control 'eks-3' do
  impact 0.9
  title 'Ensure the AWS EKS Cluster is not public'

  tag platform: "AWS"
  tag category: "Network Access Control"
  tag resource: "EKS"
  tag effort: 0.5

  describe "#{awsregion}/#{clustername}: public setting" do
    subject { aws_eks_cluster(cluster_name: clustername, aws_region: awsregion)}
    it { should_not be_public }
  end
end

control 'eks-4' do
  impact 0.3
  title 'Ensure the AWS EKS Cluster has application secrets encryption enabled'

  tag platform: "AWS"
  tag category: "Secrets Management"
  tag resource: "EKS"
  tag effort: 0.5

  describe "#{awsregion}/#{clustername}: application secrets encryption" do
    subject { aws_eks_cluster(cluster_name: clustername, aws_region: awsregion)}
    it { should have_encryption_enabled }
  end
end

control 'eks-5' do
  impact 0.3
  title 'Ensure AWS EKS Cluster Subnets are specific'

  tag platform: "AWS"
  tag category: "Network Access Control"
  tag resource: "EKS"
  tag effort: 1.0

  aws_eks_cluster(cluster_name: clustername, aws_region: awsregion).subnets.each do |subnet|
    describe "#{awsregion}/#{clustername}/#{subnet}: subnets" do
      subject { aws_subnet(subnet_id: subnet, aws_region: awsregion)}
      it { should be_available }
      it { should_not be_default_for_az }
      it { should_not be_mapping_public_ip_on_launch }
    end
  end
end

control 'eks-6' do
  impact 0.5
  title 'Ensure AWS EKS Cluster Nodegroups do not allow remote access from all IPs'

  tag platform: "AWS"
  tag category: "Network Access Control"
  tag resource: "EKS"
  tag effort: 0.3

ref "EKS Nodegroups", url: "https://docs.aws.amazon.com/eks/latest/userguide/create-managed-node-group.html"

  aws_eks_nodegroups(cluster_name: clustername, aws_region: awsregion).names.each do |nodegroup|

    describe "#{awsregion}/#{clustername}/#{nodegroup}: nodegroup" do
      subject { aws_eks_nodegroup(cluster_name: clustername, aws_region: awsregion, nodegroup_name: nodegroup)}
      it { should have_remote_access_source_security_groups }
    end

    aws_eks_nodegroup(cluster_name: clustername, aws_region: awsregion, nodegroup_name: nodegroup).remote_access_source_security_groups.each do |sg|
      describe "#{awsregion}/#{clustername}/#{nodegroup}/#{sg}: remote access source security group" do
        subject { aws_security_group(group_id: sg, aws_region: awsregion) }
        it { should_not allow_in(ipv4_range: "0.0.0.0/0", port: 22) }
      end
    end
  end
end
