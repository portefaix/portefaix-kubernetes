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
#
# SPDX-License-Identifier: Apache-2.0

CLUSTER_homelab = k3s-portefaix-homelab

KUBE_CONTEXT_homelab = k3s-portefaix-homelab

# SOPS_PROVIDER_homelab = pgp
# SOPS_KEY_homelab = 82515583D0225FABE4F4FC7874420B8A43DCF894
SOPS_PROVIDER_homelab = age
SOPS_KEY_homelab = age133ly60ep0tp9vm4t95a6c6wgvv9uqtpzsgwkw8wfneshvank79ysmew3wl
SOPS_AGE_KEY_FILE_homelab = .secrets/k3s/homelab/age/age.agekey

# MNT_DEVICE_homelab ?= /dev/mmcblk0
# MNT_DEVICE_BOOT_homelab ?= $(MNT_DEVICE_homelab)p1
# MNT_DEVICE_ROOT_homelab ?= $(MNT_DEVICE_homelab)p2

MNT_DEVICE_homelab      ?= /dev/sdb
MNT_DEVICE_BOOT_homelab ?= $(MNT_DEVICE_homelab)1
MNT_DEVICE_ROOT_homelab ?= $(MNT_DEVICE_homelab)2

MNT_ROOT_homelab = /mnt/portefaix/root
MNT_BOOT_homelab = /mnt/portefaix/boot
RPI_HOME_homelab = $(MNT_ROOT)/home/pi

K3S_SSH_KEY_homelab = ~/.ssh/id_ed25519
K3S_VERSION_homelab = v1.24.6+k3s1
K3S_USER_homelab = portefaix

AKEYLESS_PROFILE_homelab = portefaix-homelab

CLOUDFLARE_BUCKET_homelab = portefaix-homelab-tfstates
CLOUDFLARE_ACCOUNT_homelab = $(shell echo ${CLOUDFLARE_ACCOUNT_ID})
