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
sa_name = attribute("vector_sa_name")
bucket_name = attribute("vector_bucket_name")
bucket_location = attribute("vector_bucket_location")
kms_location = attribute("vector_kms_location")
key_ring_name = attribute("vector_key_ring_name")
key_name = attribute("vector_key_name")
k8s_ns = attribute("vector_k8s_ns")
k8s_sa = attribute("vector_k8s_sa")

control 'vector-1' do
  impact 1.0

  title 'Ensure service account and IAM binding exists'

  tag platform: "GCP"
  tag category: 'Service'
  tag resource: "vector"
  tag effort: 0.2

  describe google_service_account(project: project_id, name: sa_name) do
    it { should exist }
    its('display_name') { should cmp 'vector' }
  end

  describe google_storage_bucket_iam_binding(bucket: bucket_name, role: "roles/storage.objectAdmin") do
    it { should exist }
    its('members') { should include 'serviceAccount:' + sa_name}
  end

  # How test that ?
  # describe google_service_account_iam_binding(project: project_id, role: "roles/iam.workloadIdentityUser") do
  #   it { should exist }
  #   its('members') { should include 'serviceAccount:' + project_id + ".svc.id.goog[" + k8s_ns + "/" + k8s_sa + "]"}
  # end

end


control 'vector-2' do
  impact 1.0

  title 'Ensure that bucket exists'

  tag platform: "GCP"
  tag category: 'Service'
  tag resource: "vector"
  tag effort: 0.2

  describe google_storage_bucket(name: bucket_name) do
    it { should exist }
    its('location') { should cmp bucket_location.upcase }

    its('storage_class') { should eq "STANDARD" }
    its('labels') { should include(
      'env'     => "dev",
      'service' => "vector",
      'made-by' => "terraform"
    )}
    # its('retention_policy.retention_period') { should cmp 1000 }
  end


end


control 'vector-3' do
  impact 1.0

  title 'Ensure that KMS key exists'

  tag platform: "GCP"
  tag category: 'Service'
  tag resource: "vector"
  tag effort: 0.2

  describe google_kms_crypto_key(project: project_id, location: kms_location, key_ring_name: key_ring_name, name: key_name) do
    it { should exist }
    its('crypto_key_name') { should cmp key_name }
    its('primary_state') { should eq "ENABLED" }
    its('purpose') { should eq "ENCRYPT_DECRYPT" }
    its('next_rotation_time') { should be > Time.now - 100000 }
    its('create_time') { should be > Time.now - 365*60*60*24*10 }
  end

end
