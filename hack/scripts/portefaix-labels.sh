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

label="portefaix.xyz/version"

function usage() {
    echo "Usage: $0 <manifests> <version>"
}

manifests=$1
[ -z "${manifests}" ] && echo "Environment not satisfied" && exit 1
version=$2
[ -z "${version}" ] && echo "Version not satisfied" && exit 1

IFS="
"
for file in $(grep ${label} ${manifests}/*); do
    filename=$(echo ${file} | awk -F":" '{ print $1 }')
    echo -e "${INFO_COLOR}Update file: ${filename}${NO_COLOR}"
    sed -i "s#${label}:.*#${label}: ${version}#g" ${filename}
done
