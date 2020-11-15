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

control "vpc-0" do
  impact 1.0

  title "Check to see if custom VPC exists."

  tag platform: "AWS"
  tag category: 'Network'
  tag resource: "VPC"
  tag effort: 0.2

  describe aws_vpc(vpc_id) do
    it { should exist }
  end
end

control "vpc-1" do
  impact 1.0

  title "Check in all the VPCs for default sg not allowing 22 inwards"

  tag platform: "AWS"
  tag category: 'Network'
  tag resource: "VPC"
  tag effort: 0.2

  aws_vpcs.vpc_ids.each do |vpc_id|
    describe aws_security_group(vpc_id: vpc_id, group_name: "default") do
      it { should allow_in(port: 22) }
    end
  end
end

control "vpc-2" do
  impact 1.0

  title 'Check AWS VPCs in all regions have status "available"'

  tag platform: "AWS"
  tag category: 'Network'
  tag resource: "VPC"
  tag effort: 0.2

  aws_regions.region_names.each do |region|
    aws_vpcs(aws_region: region).vpc_ids.each do |vpc|
      describe aws_vpc(aws_region: region, vpc_id: vpc) do
        it { should exist }
        it { should be_available }
      end
    end
  end

end
