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

CLUSTER_homelab-tailscale = k3s-portefaix-homelab-tailscale

KUBE_CONTEXT_homelab-tailscale = k3s-portefaix-homelab-tailscale

SOPS_PROVIDER_homelab-tailscale = age
SOPS_KEY_homelab-tailscale = age133ly60ep0tp9vm4t95a6c6wgvv9uqtpzsgwkw8wfneshvank79ysmew3wl
SOPS_AGE_KEY_FILE_homelab-tailscale = .secrets/k3s/homelab/age/age.agekey

# Default variables
MNT_DEVICE_homelab-tailscale ?= /dev/mmcblk0
MNT_ROOT_homelab-tailscale    = /mnt/portefaix/root
MNT_BOOT_homelab-tailscale    = /mnt/portefaix/boot
RPI_HOME_homelab-tailscale    = $(MNT_ROOT)/home/pi

K3S_VERSION_homelab-tailscale = v1.21.4+k3s1

K3S_USER_homelab-tailscale = pi
