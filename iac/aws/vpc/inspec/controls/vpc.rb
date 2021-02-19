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

vpc_id = attribute("vpc_id")

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
      'service' => 'vpc',
      'made-by' => 'terraform'
    )}
  end

end

control "vpc-2" do
  impact 1.0

  title "Ensure that VPC have an Internet Gateway"

  tag platform: "AWS"
  tag category: 'Network'
  tag resource: "VPC"
  tag effort: 0.2

  aws_internet_gateways.ids.each do |id|
    describe aws_internet_gateway(id: id) do
      it { should be_attached }
      its('vpc_id') { should cmp vpc_id }
    end
  end

end

control "vpc-3" do
  impact 1.0

  title "Check AWS Security Groups does not have undesirable rules"

  tag platform: "AWS"
  tag category: 'Network'
  tag resource: "VPC"
  tag effort: 0.2

  aws_security_groups.group_ids.each do |group_id|
    describe aws_security_group(group_id) do
        it { should_not allow_in(port: 22, ipv4_range: '0.0.0.0/0') }
    end
  end

end

control "vpc-4" do
  impact 1.0

  title "Ensure that VPC Subnets exists"

  tag platform: "AWS"
  tag category: 'Network'
  tag resource: "VPC"
  tag effort: 0.2


  aws_subnets.where(vpc_id: vpc_id).subnet_ids.each do |subnet|
    describe aws_subnet(subnet) do
      it { should be_available }
      # its('states') { should_not include 'pending' }
      # it { should_not be_mapping_public_ip_on_launch }
      # its ('cidr_block') { should cmp subnets_list[subnet]['subnet_cidr'] }
      # its ('availability_zone') { should cmp subnets_list[subnet]['subnet_az']}
    end
    # only_if { name = /private/ }
  end
end
