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

data "aws_iam_policy_document" "assume" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "config.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "config_aggregator" {
  provider           = aws.audit
  name               = local.aggregator_role_name
  assume_role_policy = data.aws_iam_policy_document.assume.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
  ]

  tags = merge({
    Env  = "Audit"
    Role = "IAM"
  }, var.tags)
}

resource "aws_iam_role" "config_recorder" {
  provider           = aws.audit
  name               = local.recorder_role_name
  assume_role_policy = data.aws_iam_policy_document.assume.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
  ]

  tags = merge({
    Name = local.recorder_role_name
    Role = "IAM"
  }, var.tags)
}

resource "aws_iam_policy" "config_recorder" {
  provider = aws.audit
  name     = local.recorder_policy_name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "S3PutObject",
        "Effect": "Allow",
        "Action": ["s3:PutObject", "s3:PutObjectAcl"],
        "Resource": "${aws_s3_bucket.this.arn}/AWSLogs/${data.aws_caller_identity.audit.id}/*",
        "Condition": {
            "StringEquals": {
                "s3:x-amz-acl": "bucket-owner-full-control"
            }
        }
    },
    {
        "Sid": "AllGetBucketAcl",
        "Effect": "Allow",
        "Action": "s3:GetBucketAcl",
        "Resource": "${aws_s3_bucket.this.arn}"
    },
    {
        "Sid": "AllowSNSPublish",
        "Effect": "Allow",
        "Action": "sns:Publish",
        "Resource": ["*"]
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "config_recorder" {
  provider   = aws.audit
  role       = aws_iam_role.config_recorder.name
  policy_arn = aws_iam_policy.config_recorder.arn
}
