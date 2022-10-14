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

resource "aws_s3_bucket" "centralized_audit_logs" {
  provider      = aws.audit
  bucket        = local.cloudtrail_bucket_name
  force_destroy = true

  tags = merge({
    Env  = "Audit"
    Role = "S3"
  }, var.tags)
}

resource "aws_s3_bucket_versioning" "centralized_audit_logs" {
  provider = aws.audit
  bucket   = aws_s3_bucket.centralized_audit_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_access" {
  provider = aws.audit
  bucket   = aws_s3_bucket.centralized_audit_logs.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "${aws_s3_bucket.centralized_audit_logs.arn}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": [
              "${aws_s3_bucket.centralized_audit_logs.arn}/AWSLogs/${data.aws_organizations_organization.this.master_account_id}/*",
              "${aws_s3_bucket.centralized_audit_logs.arn}/AWSLogs/${data.aws_organizations_organization.this.id}/*"
            ],
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}


# resource "aws_s3_bucket_policy" "cloudtrail_access" {
#   provider = aws.audit
#   bucket = aws_s3_bucket.centralized_audit_logs.id
#   policy = <<POLICY
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "AWSCloudTrailAclCheck20150319",
#             "Effect": "Allow",
#             "Principal": {
#               "Service": "cloudtrail.amazonaws.com"
#             },
#             "Action": "s3:GetBucketAcl",
#             "Resource": "${aws_s3_bucket.centralized_audit_logs.arn}"
#         },
#         {
#             "Sid": "AWSCloudTrailWrite20150319",
#             "Effect": "Allow",
#             "Principal": {
#               "Service": "cloudtrail.amazonaws.com"
#             },
#             "Action": "s3:PutObject",
#             "Resource": "${aws_s3_bucket.centralized_audit_logs.arn}/AWSLogs/${data.aws_caller_identity.current.id}/*",
#             "Condition": {
#                 "StringEquals": {
#                     "s3:x-amz-acl": "bucket-owner-full-control",
#                     "AWS:SourceArn" : "arn:aws:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:trail/${var.cloudtrail_name}"
#                 }
#             }
#         },
#         {
#             "Sid": "AWSCloudTrailWrite20150319",
#             "Effect": "Allow",
#             "Principal": {
#                 "Service": [
#                     "cloudtrail.amazonaws.com"
#                 ]
#             },
#             "Action": "s3:PutObject",
#             "Resource": "${aws_s3_bucket.centralized_audit_logs.arn}/AWSLogs/${data.aws_organizations_organization.current.id}/*",
#             "Condition": {
#                 "StringEquals": {
#                     "s3:x-amz-acl": "bucket-owner-full-control",
#                     "AWS:SourceArn" : "arn:aws:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:trail/${var.cloudtrail_name}"
#                 }
#             }
#         }
#     ]
# }
# POLICY
# }
