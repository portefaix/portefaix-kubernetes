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

#############################################################################
# WAF

variable "service_name" {
  type        = string
  description = "Name of the service"
}

variable "description" {
  type        = string
  description = "Description"
  default     = "Managed by Terraform"
}

variable "scope" {
  type        = string
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
  default     = "REGIONAL"
  validation {
    condition     = (var.scope == "REGIONAL" || var.scope == "CLOUDFRONT")
    error_message = "Please enter either REGIONAL or CLOUDFRONT."
  }
}

variable "cloudwatch_metrics_enabled" {
  type        = bool
  description = "Indicating whether the associated resource sends metrics to CloudWatch"
  default     = false
}

variable "admin_ipv4" {
  description = "Allow Admins IP addresses for IPV4 addresses"
  type        = list(string)
  default     = []
}

variable "whitelist_ipv4" {
  description = "Allow whitelist for IPV4 addresses"
  type        = list(string)
  default     = []
}

variable "blacklist_ipv4" {
  default     = []
  type        = list(string)
  description = "Block blacklist for IPV4 addresses"
}

variable "allowed_country_codes" {
  description = "Whitelist access by country"
  type        = list(string)
  default     = []
}

variable "ip_limit" {
  description = "The limit on requests per 5-minute period for a single originating IP address"
  type        = string
  default     = "1000"
}

# AWS Managed Rules
variable "managed_rules" {
  description = "AWS managed rules to used"
  type = list(object({
    name           = string
    priority       = number
    excluded_rules = list(string)
  }))
  default = [
    {
      name           = "AWSManagedRulesAmazonIpReputationList",
      priority       = 50,
      excluded_rules = []
    },
    {
      name     = "AWSManagedRulesCommonRuleSet",
      priority = 51,
      excluded_rules = [
        "SizeRestrictions_BODY",
        "GenericRFI_BODY",
        "GenericRFI_QUERYARGUMENTS",
        "EC2MetaDataSSRF_BODY",
        "EC2MetaDataSSRF_QUERYARGUMENTS",
      ]
    },
    {
      name           = "AWSManagedRulesKnownBadInputsRuleSet",
      priority       = 52,
      excluded_rules = []
    },
    # {
    #   name           = "AWSManagedRulesLinuxRuleSet",
    #   priority       = 53,
    #   excluded_rules = []
    # },
    # {
    #   name           = "AWSManagedRulesAnonymousIpList",
    #   priority       = 54,
    #   excluded_rules = []
    # },
    {
      name           = "AWSManagedRulesSQLiRuleSet",
      priority       = 55,
      excluded_rules = []
    },
    {
      name           = "AWSManagedRulesBotControlRuleSet",
      priority       = 56,
      excluded_rules = []
    },
    # {
    #   name = "AWSManagedRulesUnixRuleSet",
    #   priority = 57,
    #   excluded_rules=[]
    #   },
    # {
    #   name = "AWSManagedRulesAdminProtectionRuleSet",
    #   priority = 58,
    #   excluded_rules=[]
    #   },
  ]
}

variable "forbidden_message" {
  type        = string
  description = "Message for custom response"
  default     = "Forbidden by Portefaix"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the WAF resources"
  default = {
    "made-by" = "terraform"
  }
}
