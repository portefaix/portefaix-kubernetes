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

provider "aws" {
  region = var.region
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "core_prod"
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${aws_organizations_account.core_prod.id}:role/OrganizationAccountAccessRole"
    session_name = format("%s-%s", var.org_name, local.core_prod_account)
  }
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "core_staging"
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${aws_organizations_account.core_staging.id}:role/OrganizationAccountAccessRole"
    session_name = format("%s-%s", var.org_name, local.core_staging_account)
  }
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "core_dev"
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${aws_organizations_account.core_dev.id}:role/OrganizationAccountAccessRole"
    session_name = format("%s-%s", var.org_name, local.core_dev_account)
  }
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "shared"
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${aws_organizations_account.shared.id}:role/OrganizationAccountAccessRole"
    session_name = format("%s-%s", var.org_name, local.shared_account)
  }
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "network"
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${aws_organizations_account.network.id}:role/OrganizationAccountAccessRole"
    session_name = format("%s-%s", var.org_name, local.network_account)
  }
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "logging"
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${aws_organizations_account.logging.id}:role/OrganizationAccountAccessRole"
    session_name = format("%s-%s", var.org_name, local.logging_account)
  }
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "testing"
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${aws_organizations_account.testing.id}:role/OrganizationAccountAccessRole"
    session_name = format("%s-%s", var.org_name, local.testing_account)
  }
  default_tags {
    tags = var.default_tags
  }
}

# provider "aws" {
#   alias  = "security"
#   region = var.region
#   assume_role {
#     role_arn     = "arn:aws:iam::${aws_organizations_account.security.id}:role/OrganizationAccountAccessRole"
#     session_name = format("%s-%s", var.org_name, local.security_account)
#   }
#   default_tags {
#     tags = var.default_tags
#   }
# }

provider "aws" {
  alias  = "audit"
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${aws_organizations_account.audit.id}:role/OrganizationAccountAccessRole"
    session_name = format("%s-%s", var.org_name, local.audit_account)
  }
  default_tags {
    tags = var.default_tags
  }
}
