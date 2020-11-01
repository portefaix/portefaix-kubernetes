# Copyright (C) 2019-2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

#####################################################################""
# Provider

variable project {
  type        = string
  description = "The project in which the resource belongs"
}

variable region {
  type        = string
  description = "The location linked to the project"
}

############################################################################
# VPC

variable subnet_name {
  type        = string
  description = "Name of the subnet"
}

variable subnet_cidr {
  type        = string
  description = "IP range of the subnet"
}

variable secondary_ranges {
  # type        = list(map(object))
  description = "Secondary ranges"
}
