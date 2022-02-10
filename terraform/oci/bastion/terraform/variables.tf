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

#######################################################################
# Provider

# variable "endpoint" {
#   description = "The Tenancy endpoint"
#   type        = string
# }

variable "tenancy_ocid" {
  description = "tenancy id where to create the sources"
  type        = string
}

variable "user_ocid" {
  description = "id of user that terraform will use to create the resources"
  type        = string
}

variable "fingerprint" {
  description = "fingerprint of oci api private key"
  type        = string
}

variable "private_key" {
  description = "OCI api private key used"
  type        = string
}

variable "region" {
  description = "the oci region where resources will be created"
  type        = string
}

#######################################################################
# Networking

variable "vcn_display_name" {
  default     = ""
  description = "Name of the existing Virtual Cloud Network"
  type        = string
}

variable "ig_route_table_display_name" {
  default     = ""
  description = "Name of the existing NAT Gateway route table"
  type        = string
}

#######################################################################
# Bastion

variable "bastion_access" {
  description = "A list of CIDR blocks to which ssh access to the bastion must be restricted to. *anywhere* is equivalent to 0.0.0.0/0 and allows ssh access from anywhere."
  default     = ["anywhere"]
  type        = list(string)
}

variable "bastion_image_id" {
  description = "Provide a custom image id for the bastion host or leave as Autonomous."
  type        = string
}

variable "bastion_os_version" {
  description = "In case Autonomous Linux is used, allow specification of Autonomous version"
  type        = string
}

variable "bastion_shape" {
  description = "The shape of bastion instance."
  type        = map(any)
}

variable "bastion_state" {
  description = "The target state for the instance. Could be set to RUNNING or STOPPED. (Updatable)"
  default     = "RUNNING"
  type        = string
}

variable "bastion_timezone" {
  description = "The preferred timezone for the bastion host."
  default     = "Europe/Paris"
  type        = string
}

variable "bastion_type" {
  description = "Whether to make the bastion host public or private."
  default     = "public"
  type        = string
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the ssh public key used to access the bastion. set this or the ssh_public_key"
  default     = "~/.ssh/id_ed25519.pub"
}

variable "upgrade_bastion" {
  description = "Whether to upgrade the bastion host packages after provisioning. It's useful to set this to false during development/testing so the bastion is provisioned faster."
  default     = false
  type        = bool
}

# bastion notification
variable "enable_bastion_notification" {
  description = "Whether to enable ONS notification for the bastion host."
  default     = false
  type        = bool
}

# variable "bastion_notification_endpoint" {
#   description = "The subscription notification endpoint. Email address to be notified."
#   default     = null
#   type        = string
# }

# variable "bastion_notification_protocol" {
#   description = "The notification protocol used."
#   default     = "EMAIL"
#   type        = string
# }

# variable "bastion_notification_topic" {
#   description = "The name of the notification topic"
#   default     = "bastion"
#   type        = string
# }

variable "freeform_tags" {
  description = "Freeform tags for bastion"
  type        = map(string)
  default = {
    made-by = "terraform"
  }
}
