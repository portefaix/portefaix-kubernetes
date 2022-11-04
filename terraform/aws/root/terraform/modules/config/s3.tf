# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
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

#tfsec:ignore:aws-s3-no-public-buckets
#tfsec:ignore:aws-s3-enable-bucket-logging
module "bucket_awsconfig" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.5.0"

  bucket = local.bucket_name
  #   policy = data.aws_iam_policy_document.config_bucket.json
  # force_destroy = true

  tags = merge({
    Name = local.bucket_name
    Role = "S3"
  }, var.tags)

  versioning = {
    enabled = true
  }
}

resource "aws_iam_role_policy" "bucket" {
  name = local.role_policy_name
  role = aws_iam_role.this.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${module.bucket_awsconfig.s3_bucket_arn}",
        "${module.bucket_awsconfig.s3_bucket_arn}/*"
      ]
    }
  ]
}
POLICY
}
