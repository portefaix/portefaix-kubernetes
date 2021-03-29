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
sa_name = attribute("grafana_sa_name")
k8s_ns = attribute("grafana_k8s_ns")
k8s_sa = attribute("grafana_k8s_sa")

control 'grafana-1' do
  impact 1.0

  title 'Ensure service account and IAM binding exists'

  tag platform: "GCP"
  tag category: 'Service'
  tag resource: "Grafana"
  tag effort: 0.2

  describe google_service_account(project: project_id, name: sa_name) do
    it { should exist }
    its('display_name') { should cmp 'grafana' }
  end

  describe google_project_iam_binding(project: project_id, role: "roles/monitoring.viewer") do
    it { should exist }
    its('members') { should include 'serviceAccount:' + sa_name}
  end

  # How test that ?
  # describe google_service_account_iam_binding(project: project_id, role: "roles/iam.workloadIdentityUser") do
  #   it { should exist }
  #   its('members') { should include 'serviceAccount:' + project_id + ".svc.id.goog[" + k8s_ns + "/" + k8s_sa + "]"}
  # end

end
