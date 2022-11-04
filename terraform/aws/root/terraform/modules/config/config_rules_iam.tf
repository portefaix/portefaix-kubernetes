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

resource "aws_config_config_rule" "iam_root_account_mfa_enabled" {
  name        = format("%s-iam-root-account-mfa-enabled", var.org_name)
  description = "Ensure root AWS account has MFA enabled"

  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }

  tags = merge({
    Name = format("%s-iam-root-account-mfa-enabled", var.org_name)
    Role = "IAM"
  }, var.tags)


  depends_on = [aws_config_configuration_recorder.this]
}

resource "aws_config_config_rule" "iam_mfa_enabled_for_iam_console_access" {
  name        = format("%s-iam-mfa-enabled-for-iam-console-access", var.org_name)
  description = "Checks whether AWS Multi-Factor Authentication (MFA) is enabled for all AWS Identity and Access Management (IAM) users that use a console password. The rule is compliant if MFA is enabled."

  source {
    owner             = "AWS"
    source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
  }

  tags = merge({
    Name = format("%s-iam-mfa-enabled-for-iam-console-access", var.org_name)
    Role = "IAM"
  }, var.tags)

  depends_on = [aws_config_configuration_recorder.this]
}


resource "aws_config_config_rule" "iam_access_keys_rotated" {
  name        = format("%s-iam-access-keys-rotated", var.org_name)
  description = "Checks if the active access keys are rotated within the number of days specified in maxAccessKeyAge"

  source {
    owner             = "AWS"
    source_identifier = "ACCESS_KEYS_ROTATED"
  }

  input_parameters = jsonencode({
    maxAccessKeyAge = "30"
  })

  tags = merge({
    Name = format("%s-access-keys-rotated", var.org_name)
    Role = "IAM"
  }, var.tags)

  depends_on = [aws_config_configuration_recorder.this]
}