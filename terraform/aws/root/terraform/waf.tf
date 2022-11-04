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

module "bucket_waf_core" {
  for_each = toset([local.core_dev_account, local.core_staging_account, local.core_prod_account])

  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.5.0"

  providers = {
    aws = aws.logging
  }

  bucket = format("%s-waf-%s-logs", var.org_name, each.value)

  # force_destroy = true

  tags = merge({
    "Name"    = format("%s-waf-%s-logs", var.org_name, each.value),
    "Service" = "WAF"
    },
    var.tags
  )

  versioning = {
    enabled = true
  }
}

data "aws_iam_policy_document" "bucket_waf_core_dev" {
  provider = aws.logging

  statement {
    sid    = "AllowPortefaixCoreDev"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${aws_organizations_account.core_dev.id}:root"
      ]
    }

    actions = ["s3:*"]

    resources = [
      format("arn:aws:s3:::%s/*", module.bucket_waf_core[local.core_dev_account].s3_bucket_id),
      format("arn:aws:s3:::%s", module.bucket_waf_core[local.core_dev_account].s3_bucket_id),
    ]
  }
}

resource "aws_s3_bucket_policy" "bucket_waf_core_dev" {
  provider = aws.logging

  bucket = module.bucket_waf_core[local.core_dev_account].s3_bucket_id
  policy = data.aws_iam_policy_document.bucket_waf_core_dev.json
}

data "aws_iam_policy_document" "bucket_waf_core_staging" {
  provider = aws.logging

  statement {
    sid    = "AllowPortefaixCoreDev"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${aws_organizations_account.core_staging.id}:root"
      ]
    }

    actions = ["s3:*"]

    resources = [
      format("arn:aws:s3:::%s/*", module.bucket_waf_core[local.core_staging_account].s3_bucket_id),
      format("arn:aws:s3:::%s", module.bucket_waf_core[local.core_staging_account].s3_bucket_id),
    ]
  }
}

resource "aws_s3_bucket_policy" "bucket_waf_core_staging" {
  provider = aws.logging

  bucket = module.bucket_waf_core[local.core_staging_account].s3_bucket_id
  policy = data.aws_iam_policy_document.bucket_waf_core_staging.json
}
