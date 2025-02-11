#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

NO_COLOR="\033[0m"
# DEBUG_COLOR="\e[34m"
OK_COLOR="\e[32m"
ERROR_COLOR="\e[31m"
# WARN_COLOR="\e[35m"
INFO_COLOR="\e[36m"

shopt -s nullglob # enable

PI_OS_NAME="bullseye"
PI_OS_RELEASE="2022-01-28"
PI_OS_VERSION="2022-01-28"

if [ $# -ne 2 ]; then
    echo -e "${ERROR_COLOR}Usage: $0 hostname device${NO_COLOR}"
    echo "Parameters:"
    echo "- hostname    : Set hostname for this SD image"
    echo "- device      : Card device to flash to (e.g. /dev/sdb in Linux or /dev/disk2 in OSX)"
    exit 1
fi

device=$1

echo -e "${OK_COLOR}== Portefaix ==${NO_COLOR}"

if [ ! -f "${PI_OS_VERSION}-raspios-${PI_OS_NAME}-arm64-lite.img" ]; then
    echo -e "${INFO_COLOR}Download image: ${NO_COLOR}${PI_OS_VERSION}"
    curl -LO --progress-bar "https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-${PI_OS_RELEASE}/${PI_OS_VERSION}-raspios-${PI_OS_NAME}-arm64-lite.zip"
    unzip "${PI_OS_VERSION}-raspios-${PI_OS_NAME}-arm64-lite.zip"
fi

echo -e "${INFO_COLOR}Setup OS${NO_COLOR}"
sudo dd if="${PI_OS_VERSION}-raspios-${PI_OS_NAME}-arm64-lite.img" of="${device}" bs=4M conv=fsync status=progress
