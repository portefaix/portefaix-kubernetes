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

# Documentation:
# https://docs.microsoft.com/en-us/rest/api/aks/managedclusters/get

resourcegroup = attribute('resourcegroup', description:'Azure resource group')
clustername = attribute("clustername", description:'The Kubernetes cluster name')

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

# control "aks-0" do
#   title "AKS Debug"
#   describe "#{resourcegroup}/#{clustername}:" do
#     subject { azure_aks_cluster(resource_group: resourcegroup, name: clustername) }
#     it { should have_logging_enabled }
#     it { should exist }
#     its('properties.provisioningState') { should cmp 'Succeeded' }
#     # its('properties.kubernetesVersion') { should cmp '1.18.8' }
#     # its('properties.dnsPrefix') { should cmp 'ClusterName' }
#     # its('properties.fqdn') { should cmp 'ClusterName' }
#     its('properties.agentPoolProfiles.first.name') { should cmp 'core' }
#     its('properties.agentPoolProfiles.first.count') { should cmp 1 }
#     its('properties.agentPoolProfiles.first.vmSize') { should cmp 'Standard_D2s_v3' }
#     # its('properties.agentPoolProfiles.first.storageProfile') { should cmp 'ManagedDisks' }
#     its('properties.agentPoolProfiles.first.maxPods') { should cmp 110 }
#     its('properties.agentPoolProfiles.first.osType') { should cmp 'Linux' }
#   end
# end

# COST !!!
# control "aks-1" do
#   impact 0.9

#   title "Ensure logging to Azure Monitor is configured"

#   tag platform: "Azure"
#   tag category: 'Logging / Monitoring'
#   tag resource: "AKS"
#   tag effort: 0.2

#   describe "#{resourcegroup}/#{clustername}:" do
#     subject { azure_aks_cluster(resource_group: resourcegroup, name: clustername) }
#     its('properties.addonProfiles.omsagent.enabled') { should cmp true }
#   end
# end

control "aks-1" do
  impact 1.0

  title "Ensure RBAC is enabled"

  tag platform: "Azure"
  tag category: "Identity and Access Management"
  tag resource: "AKS"
  tag effort: 1.0

  describe "#{resourcegroup}/#{clustername}:" do
    subject { azure_aks_cluster(resource_group: resourcegroup, name: clustername) }
    its('properties.enableRBAC') { should cmp true }
  end
end

control "aks-2" do
  impact 0.8

  title "Ensure API Server Authorized IP Ranges are configured"

  tag platform: "Azure"
  tag category: "Network Access Control"
  tag resource: "AKS"
  tag effort: 0.5

  describe "#{resourcegroup}/#{clustername}:" do
    subject { azure_aks_cluster(resource_group: resourcegroup, name: clustername) }
    its('properties.apiServerAccessProfile.authorizedIPRanges') { should_not be_empty }
    its('properties.apiServerAccessProfile.authorizedIPRanges.to_s') { should_not include '[0.0.0.0/0]' }
  end
end

control "aks-3" do
  impact 0.8

  title "Ensure network plugin is Azure CNI and network policy is Calico"

  tag platform: "Azure"
  tag category: "Network Access Control"
  tag resource: "AKS"
  tag effort: 0.9

  describe "#{resourcegroup}/#{clustername}:" do
    subject { azure_aks_cluster(resource_group: resourcegroup, name: clustername) }
    its('properties.networkProfile.networkPlugin') { should = "azure" }
    its('properties.networkProfile.networkPolicy') { should = "calico" }
  end

end
