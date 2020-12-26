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

key_id = attribute("thanos_key_id")
bucket_name = attribute("thanos_bucket_name")
role_name = attribute("thanos_role_name")
policy_name = attribute("thanos_policy_name")


control "thanos-1" do
  impact 1.0

  title "Check that S3 bucket exist"

  tag platform: "AWS"
  tag category: 'Service'
  tag resource: "thanos"
  tag effort: 0.2

  describe aws_s3_bucket(bucket_name) do
    it { should exist }
    it { should_not be_public }
    its('tags') { should include(
      'made-by' => 'terraform',
      'project' => 'foo',
      'service' => 'thanos'
    )}
    it { should have_default_encryption_enabled }
  end

end

control "thanos-2" do
  impact 1.0

  title "Check that Kms key exist and tags are correctly set"

  tag platform: "AWS"
  tag category: 'Service'
  tag resource: "thanos"
  tag effort: 0.2

  describe aws_kms_key(key_id) do
    it { should exist }
    # its('tags') { should include(
    #   'made-by' => 'terraform',
    #   'project' => 'portefaix',
    #   'service' => 'thanos'
    # )}
  end

end

control "thanos-3" do
  impact 1.0

  title "Check IAM"

  tag platform: "AWS"
  tag category: 'Service'
  tag resource: "thanos"
  tag effort: 0.2

  describe aws_iam_role(role_name: role_name) do
    it { should exist }
    # its('tags') { should include(
    #   'made-by' => 'terraform',
    #   'project' => 'portefaix',
    #   'service' => 'thanos'
    # )}
  end

  describe aws_iam_policy(policy_name: policy_name) do
    it { should exist }
  end

end

