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

role_name = attribute("grafana_role_name")
policy_name = attribute("grafana_policy_name")

control "grafana-1" do
  impact 1.0

  title "Ensure IAM roles and policies exists"

  tag platform: "AWS"
  tag category: 'Service'
  tag resource: "grafana"
  tag effort: 0.2

  describe aws_iam_role(role_name: role_name) do
    it { should exist }
    # its('tags') { should include(
    #   'made-by' => 'terraform',
    #   'project' => 'portefaix',
    #   'service' => 'grafana'
    # )}
  end

  describe aws_iam_policy(policy_name: policy_name) do
    it { should exist }
  end

end
