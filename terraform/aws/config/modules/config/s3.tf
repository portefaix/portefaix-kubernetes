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

resource "aws_s3_bucket" "this" {
  provider      = aws.audit
  bucket        = local.bucket_name
  force_destroy = true

  tags = merge({
    Env  = "Logging"
    Role = "S3"
  }, var.tags)
}

resource "aws_s3_bucket_versioning" "this" {
  provider = aws.audit
  bucket   = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
#   provider = aws.audit
#   bucket   = aws_s3_bucket.this.id

#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = module.kms_key.arn
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }

resource "aws_s3_bucket_policy" "this" {
  provider = aws.audit
  bucket   = aws_s3_bucket.this.id
  policy   = data.aws_iam_policy_document.bucket.json
}

data "aws_iam_policy_document" "bucket" {
  provider = aws.audit

  statement {
    sid    = "AWSConfigBucketPermissionsCheck"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${local.bucket_name}"]
  }

  statement {
    sid    = "AWSConfigReadAccess"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl",
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::${local.bucket_name}"]
  }

  statement {
    sid    = "AWSConfigWriteAccess"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions = ["s3:PutObject"]

    resources = ["arn:aws:s3:::${local.bucket_name}/AWSLogs/${data.aws_caller_identity.audit.id}/Config/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
