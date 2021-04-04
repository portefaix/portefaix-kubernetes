#!/usr/bin/env bash

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

NO_COLOR="\033[0m"
DEBUG_COLOR="\e[34m"
INFO_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
WARN_COLOR="\e[35m"

shopt -s nullglob # enable
retcode=0
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

FLASH_VERSION="2.7.1"
UBUNTU_RELEASE="20.04"
UBUNTU_VERSION="${UBUNTU_RELEASE}.2"

if [ $# -ne 4 ]; then
	echo -e "${ERROR_COLOR}Usage: $0 hostname ssid wifipassword device${NO_COLOR}"
	echo "Parameters:"
	echo "- hostname    : Set hostname for this SD image"
	echo "- ssid        : Set WiFi SSID for this SD image"
	echo "- password    : Set WiFI password for this SD image"
	echo "- device      : Card device to flash to (e.g. /dev/sdb in Linux or /dev/disk2 in OSX)"
	exit 1
fi

hostname=$1
ssid=$2
wifipassword=$3
device=$4

echo -e "${OK_COLOR}== Jarvis ==${NO_COLOR}"

echo -e "${INFO_COLOR}Download flash: v${FLASH_VERSION}${NO_COLOR}"
# curl -LO --progress-bar --silent "https://github.com/hypriot/flash/releases/download/${FLASH_VERSION}/flash"
# chmod +x ./flash

echo -e "${INFO_COLOR}Download Ubuntu image: ubuntu-${UBUNTU_VERSION}${NO_COLOR}"
# curl -LO --progress-bar https://cdimage.ubuntu.com/releases/${UBUNTU_RELEASE}/release/ubuntu-${UBUNTU_VERSION}-preinstalled-server-arm64+raspi.img.xz
# xz -d ./ubuntu-${UBUNTU_VERSION}-preinstalled-server-arm64+raspi.img.xz

echo -e "${INFO_COLOR}Setup OS${NO_COLOR}"
./flash \
	--hostname ${hostname} \
    --userdata ${DIR}/cloud-config.yml \
	--device ${device} \
    ./ubuntu-${UBUNTU_VERSION}-preinstalled-server-arm64+raspi.img

# --ssid ${ssid} --password ${wifipassword} \
