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

# Documentation:
# https://docs.microsoft.com/en-us/rest/api/aks/managedclusters/get

resource_group = attribute('resourcegroup', description:'Azure resource group')
location = attribute('location', description:'Azure location')
address_space = attribute('address_space', description:"Virtual network address space")


# control 'debug-1' do
#   impact 1.0

#   title 'Ensure Azure resource group'

#   tag platform: 'Azure'
#   tag category: 'Setup'
#   tag resource: 'Resource Group'
#   tag effort: 0.2

#   describe azure_resource_group(name: resourcegroup) do
#     it { should exist }
#   end

# end


control "vnet-1" do
  impact 0.9

  title "Ensure location of the virtual network"

  tag platform: "Azure"
  tag category: 'Logging / Monitoring'
  tag resource: "VPC"
  tag effort: 0.2

  describe azure_virtual_network(resource_group: resource_group, name: 'portefaix-dev') do
    it { should exist }
    its('location')  { should eq "#{location}" }
    its('type') { should eq 'Microsoft.Network/virtualNetworks' }
    its('subnets') { should eq ["#{resource_group}-aks-nodes"] }
    its('address_space') { should eq ["#{address_space}"] }
    # its('dns_servers') { should eq ["1.1.1.1", "1.0.0.1"] }
    # its('enable_ddos_protection') { should eq false }
    its('tags') { should include(project: 'portefaix') }
    its('tags') { should include(env: 'dev') }
    its('tags') { should include("made-by": 'terraform') }
  end

end

control "vnet-2" do
  impact 0.9

  title "Ensure properties of a Network Security Group"

  tag platform: "Azure"
  tag category: 'Network'
  tag resource: "VPC"
  tag effort: 0.2

  describe azure_network_security_groups(resource_group: resource_group) do
    its('type') { should eq 'Microsoft.Network/networkSecurityGroups' }
    its('security_rules') { should_not be_empty }
    its('default_security_rules') { should_not be_empty }
    it { should_not allow_rdp_from_internet }
    it { should_not allow_ssh_from_internet }
    # it { should allow(source_ip_range: '0.0.0.0', destination_port: '22', direction: 'inbound') }
    # it { should allow_in(service_tag: 'Internet', port: %w{1433-1434 1521 4300-4350 5000-6000}) }
  end

end