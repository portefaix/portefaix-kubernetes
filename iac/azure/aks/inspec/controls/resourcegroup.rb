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

resourcegroup = attribute('resourcegroup', description:'Azure resource group')
clustername = attribute("clustername", description:'The Kubernetes cluster name')

control 'resourcegroup-1' do
  impact 1.0

  title 'Ensure Azure resource group'

  tag platform: 'Azure'
  tag category: 'Setup'
  tag resource: 'Resource Group'
  tag effort: 0.2

  describe azure_resource_group(name: resourcegroup) do
    it { should exist }
  end

end

