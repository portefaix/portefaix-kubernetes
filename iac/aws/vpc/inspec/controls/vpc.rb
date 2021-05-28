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

vpc_id = attribute('vpc_id')
project_env = attribute('project_env')

control "vpc-1" do
  impact 1.0

  title "Ensure that VPC exist and tags correcly set"

  tag platform: "AWS"
  tag category: 'Network'
  tag resource: "VPC"
  tag effort: 0.2

  describe aws_vpc(vpc_id) do
    it { should exist }
    its ('state') { should eq 'available' }
    it { should_not be_default }
    its('tags') { should include(
      'project' => 'portefaix',
      'env' => project_env
    )}
  end

end
