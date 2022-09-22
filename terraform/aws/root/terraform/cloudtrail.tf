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

data "aws_iam_policy_document" "cloudtrail_s3_policy" {
  provider = aws.logging

  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_cloudtrail_name}",
    ]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_cloudtrail_name}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }
}

module "bucket_cloudtrail" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.2.3"

  providers = {
    aws = aws.logging
  }

  bucket = local.bucket_cloudtrail_name

  force_destroy = true

  attach_policy = true
  policy        = data.aws_iam_policy_document.cloudtrail_s3_policy.json

  tags = merge({
    "Name"    = format("%s-cloudtrail", var.org_name),
    "Service" = "Cloudtrail"
    },
    var.tags
  )

  versioning = {
    enabled = true
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  provider = aws.logging

  bucket = module.bucket_cloudtrail.s3_bucket_id
  policy = data.aws_iam_policy_document.cloudtrail_s3_policy.json
}
