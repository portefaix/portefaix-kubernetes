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

resource "aws_iam_group" "sre" {
  name = format("%sSRE", title(var.org_name))
  path = "/"
}

# resource "aws_iam_group_policy_attachment" "sre" {
#   group      = aws_iam_group.sre.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }

resource "aws_iam_group_policy" "sre_admin" {
  group  = aws_iam_group.sre.name
  name   = format("%sSRE", title(var.org_name))
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Resource": [
        "${aws_iam_role.audit.arn}",
        "${aws_iam_role.core_dev.arn}",
        "${aws_iam_role.core_prod.arn}",
        "${aws_iam_role.core_staging.arn}",
        "${aws_iam_role.logging.arn}",
        "${aws_iam_role.network.arn}",
        "${aws_iam_role.shared.arn}"
      ],
      "Effect": "Allow",
      "Sid": "AllowAll"
    },
    {
      "Action": [
        "organizations:ListAccounts"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "AllowOrga"
    }
  ]
}
EOF
}

resource "aws_iam_group" "dev" {
  name = format("%sDevelopment", title(var.org_name))
  path = "/"
}

resource "aws_iam_group" "billing" {
  name = format("%sBilling", title(var.org_name))
  path = "/"
}

module "billing" {
  source = "./modules/iam_billing"

  org_name = var.org_name
  account  = "Root"

  tags = merge({
    "Service" = "IAM"
    },
  var.tags)
}

resource "aws_iam_group" "audit" {
  name = format("%sAudit", title(var.org_name))
  path = "/"
}

data "aws_iam_policy_document" "force_mfa" {

  statement {
    sid    = "AllowAllUsersToListAccounts"
    effect = "Allow"
    actions = [
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation"
    effect = "Allow"
    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:GetLoginProfile",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:UpdateLoginProfile",
      "iam:ListSigningCertificates",
      "iam:DeleteSigningCertificate",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
      "iam:ListSSHPublicKeys",
      "iam:GetSSHPublicKey",
      "iam:DeleteSSHPublicKey",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey"
    ]
    resources = [
      "arn:aws:iam::*:user/&{aws:username}"
    ]
  }

  statement {
    sid    = "AllowIndividualUserToListOnlyTheirOwnMFA"
    effect = "Allow"
    actions = [
      "iam:ListMFADevices"
    ]
    resources = [
      "arn:aws:iam::*:mfa/*",
      "arn:aws:iam::*:user/&{aws:username}"
    ]
  }

  statement {
    sid    = "AllowIndividualUserToManageTheirOwnMFA"
    effect = "Allow"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice"
    ]
    resources = [
      "arn:aws:iam::*:mfa/&{aws:username}",
      "arn:aws:iam::*:user/&{aws:username}"
    ]
  }

  statement {
    sid    = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA"
    effect = "Allow"
    actions = [
      "iam:DeactivateMFADevice"
    ]
    resources = [
      "arn:aws:iam::*:mfa/&{aws:username}",
      "arn:aws:iam::*:user/&{aws:username}"
    ]
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values = [
        "true"
      ]
    }
  }

  statement {
    sid    = "BlockMostAccessUnlessSignedInWithMFA"
    effect = "Deny"
    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:ListVirtualMFADevices",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:ListSSHPublicKeys",
      "iam:ListAccessKeys",
      "iam:ListServiceSpecificCredentials",
      "iam:ListMFADevices",
      "iam:GetAccountSummary",
      "sts:GetSessionToken"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values = [
        "false",
      ]
    }
  }
}


# data "aws_iam_policy_document" "force_mfa_but_allow_sign_in_to_change_password" {
#   statement {
#     sid = "AllowAllUsersToListAccounts"
#     effect = "Allow"
#     actions = [
#       "iam:ListAccountAliases",
#       "iam:ListUsers",
#       "iam:ListVirtualMFADevices",
#       "iam:GetAccountPasswordPolicy",
#       "iam:GetAccountSummary"
#     ]
#     resources = [
#       "*"
#     ]
#   }

#   statement {
#     sid = "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation"
#     effect = "Allow"
#     actions = [
#       "iam:ChangePassword",
#       "iam:CreateAccessKey",
#       "iam:CreateLoginProfile",
#       "iam:DeleteAccessKey",
#       "iam:DeleteLoginProfile",
#       "iam:GetLoginProfile",
#       "iam:ListAccessKeys",
#       "iam:UpdateAccessKey",
#       "iam:UpdateLoginProfile",
#       "iam:ListSigningCertificates",
#       "iam:DeleteSigningCertificate",
#       "iam:UpdateSigningCertificate",
#       "iam:UploadSigningCertificate",
#       "iam:ListSSHPublicKeys",
#       "iam:GetSSHPublicKey",
#       "iam:DeleteSSHPublicKey",
#       "iam:UpdateSSHPublicKey",
#       "iam:UploadSSHPublicKey"
#     ]
#     resources = [
#       "arn:aws:iam::*:user/&{aws:username}"
#     ]
#   }

#   statement {
#     sid = "AllowIndividualUserToListOnlyTheirOwnMFA"
#     effect = "Allow"
#     actions = [
#       "iam:ListMFADevices"
#     ]
#     resources = [
#       "arn:aws:iam::*:mfa/*",
#       "arn:aws:iam::*:user/&{aws:username}"
#     ]
#   }

#   statement {
#     sid = "AllowIndividualUserToManageTheirOwnMFA"
#     effect = "Allow"
#     actions = [
#       "iam:CreateVirtualMFADevice",
#       "iam:DeleteVirtualMFADevice",
#       "iam:EnableMFADevice",
#       "iam:ResyncMFADevice"
#     ]
#     resources = [
#       "arn:aws:iam::*:mfa/&{aws:username}",
#       "arn:aws:iam::*:user/&{aws:username}"
#     ]
#   }

#   statement {
#     sid = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA"
#     effect = "Allow"
#     actions = [
#       "iam:DeactivateMFADevice"
#     ]
#     resources = [
#       "arn:aws:iam::*:mfa/&{aws:username}",
#       "arn:aws:iam::*:user/&{aws:username}"
#     ]
#     condition {
#       test = "Bool"
#       variable = "aws:MultiFactorAuthPresent"
#       values = [
#         "true"
#       ]
#     }
#   }

#   statement {
#     sid = "BlockMostAccessUnlessSignedInWithMFA"
#     effect = "Deny"
#     not_actions = [
#       "iam:ChangePassword",
#       "iam:CreateLoginProfile",
#       "iam:CreateVirtualMFADevice",
#       "iam:DeleteVirtualMFADevice",
#       "iam:ListVirtualMFADevices",
#       "iam:EnableMFADevice",
#       "iam:ResyncMFADevice",
#       "iam:ListAccountAliases",
#       "iam:ListUsers",
#       "iam:ListSSHPublicKeys",
#       "iam:ListAccessKeys",
#       "iam:ListServiceSpecificCredentials",
#       "iam:ListMFADevices",
#       "iam:GetAccountSummary",
#       "sts:GetSessionToken"
#     ]
#     resources = [
#       "*"
#     ]
#     condition {
#       test = "BoolIfExists"
#       variable = "aws:MultiFactorAuthPresent"
#       values = [
#         "false",
#       ]
#     }
#   }
# }

resource "aws_iam_policy" "force_mfa" {
  name   = format("%sForceMFA", title(var.org_name))
  path   = "/"
  policy = data.aws_iam_policy_document.force_mfa.json
  # policy = data.aws_iam_policy_document.force_mfa_but_allow_sign_in_to_change_password.json

  tags = merge({
    "Name"    = format("%sForceMFA", title(var.org_name)),
    "Service" = "IAM"
    },
    var.tags
  )
}

resource "aws_iam_group" "mfa" {
  name = format("%sForceMFA", title(var.org_name))
  path = "/"
}

resource "aws_iam_group_policy_attachment" "mfa_force_mfa" {
  group      = aws_iam_group.mfa.name
  policy_arn = aws_iam_policy.force_mfa.arn
}

resource "aws_iam_group_policy_attachment" "sre_force_mfa" {
  group      = aws_iam_group.sre.name
  policy_arn = aws_iam_policy.force_mfa.arn
}

resource "aws_iam_group_policy_attachment" "billing_force_mfa" {
  group      = aws_iam_group.billing.name
  policy_arn = aws_iam_policy.force_mfa.arn
}

resource "aws_iam_group_policy" "billing_group" {
  group  = aws_iam_group.billing.name
  name   = format("%sBilling", title(var.org_name))
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Resource": [
        "${module.billing.iam_role_arn}"
      ],
      "Effect": "Allow",
      "Sid": "AllowAll"
    },
    {
      "Action": [
        "organizations:ListAccounts"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "AllowOrga"
    }
  ]
}
EOF
}

resource "aws_iam_group_policy_attachment" "dev_force_mfa" {
  group      = aws_iam_group.dev.name
  policy_arn = aws_iam_policy.force_mfa.arn
}

resource "aws_iam_group_policy_attachment" "audit_force_mfa" {
  group      = aws_iam_group.audit.name
  policy_arn = aws_iam_policy.force_mfa.arn
}

resource "aws_iam_group_policy" "audit_group" {
  group  = aws_iam_group.audit.name
  name   = format("%sAudit", title(var.org_name))
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Resource": [
        "${module.audit_audit.iam_role_arn}",
        "${module.core_dev_audit.iam_role_arn}",
        "${module.core_prod_audit.iam_role_arn}",
        "${module.core_staging_audit.iam_role_arn}",
        "${module.logging_audit.iam_role_arn}",
        "${module.network_audit.iam_role_arn}",
        "${module.shared_audit.iam_role_arn}"
      ],
      "Effect": "Allow",
      "Sid": "AllowAll"
    },
    {
      "Action": [
        "organizations:ListAccounts"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "AllowOrga"
    }
  ]
}
EOF
}
