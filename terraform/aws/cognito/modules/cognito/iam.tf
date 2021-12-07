# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

resource "aws_iam_role" "authenticated" {
  name = format("%s-authenticated", var.service_name)

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.this.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF

  tags = var.tags
}

# resource "aws_iam_role" "unauthenticated" {
#   name = format("%s-unauthenticated", var.service_name)

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::000000000000:root"
#       },
#       "Action": "sts:AssumeRole",
#       "Condition": {
#         "Bool": {
#           "aws:MultiFactorAuthPresent": "true"
#         }
#       }
#     }
#   ]
# }
# EOF
#   tags = var.tags
# }

#tfsec:ignore:AWS099
resource "aws_iam_role_policy" "authenticated" {
  name = format("%s-authenticated", var.service_name)
  role = aws_iam_role.authenticated.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*",
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

# resource "aws_iam_role_policy" "unauthenticated" {
#   name = format("%s-authenticated", var.service_name)
#   role = aws_iam_role.apps_identity_pool_unauthenticated.id

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Deny",
#       "Action": [
#         "*"
#       ],
#       "Resource": [
#         "*"
#       ]
#     }
#   ]
# }
# EOF
# }

resource "aws_iam_group" "cognito_app_group" {
  name = format("%s-cognito", var.service_name)
}

resource "aws_iam_user" "cognito_app_user" {
  name = format("%s-cognito", var.service_name)
}

resource "aws_iam_user_group_membership" "cognito_app_user_groups" {
  user = aws_iam_user.cognito_app_user.name

  groups = [
    aws_iam_group.cognito_app_group.name,
  ]
}

#tfsec:ignore:AWS099
data "aws_iam_policy_document" "cognito_app_group_policy" {
  statement {
    actions = [
      "cognito-idp:ListUserPools",
      "cognito-idp:ListUsers",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "cognito-idp:AdminAddUserToGroup",
      "cognito-idp:AdminConfirmSignUp",
      "cognito-idp:AdminCreateUser",
      "cognito-idp:AdminDeleteUser",
      "cognito-idp:AdminDeleteUserAttributes",
      "cognito-idp:AdminDisableProviderForUser",
      "cognito-idp:AdminDisableUser",
      "cognito-idp:AdminEnableUser",
      "cognito-idp:AdminForgetDevice",
      "cognito-idp:AdminGetDevice",
      "cognito-idp:AdminGetUser",
      "cognito-idp:AdminInitiateAuth",
      "cognito-idp:AdminLinkProviderForUser",
      "cognito-idp:AdminListDevices",
      "cognito-idp:AdminListGroupsForUser",
      "cognito-idp:AdminListUserAuthEvents",
      "cognito-idp:AdminRemoveUserFromGroup",
      "cognito-idp:AdminResetUserPassword",
      "cognito-idp:AdminRespondToAuthChallenge",
      "cognito-idp:AdminSetUserMFAPreference",
      "cognito-idp:AdminSetUserSettings",
      "cognito-idp:AdminUpdateAuthEventFeedback",
      "cognito-idp:AdminUpdateDeviceStatus",
      "cognito-idp:AdminUpdateUserAttributes",
      "cognito-idp:AdminUserGlobalSignOut",
    ]

    resources = [
      aws_cognito_user_pool.this.arn,
    ]
  }
}

resource "aws_iam_policy" "cognito_app_group_policy" {
  name   = format("%s-group", var.service_name)
  policy = data.aws_iam_policy_document.cognito_app_group_policy.json
  tags   = var.tags
}

resource "aws_iam_group_policy_attachment" "cognito_app_group_attachment" {
  group      = aws_iam_group.cognito_app_group.name
  policy_arn = aws_iam_policy.cognito_app_group_policy.arn
}
