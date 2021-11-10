#!/bin/bash
# Copyright 2021 Nicolas Lamirault.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################
# See <https://gist.github.com/Falkor/848c82daa63710b6c132bb42029b30ef>
# Pre-commit hook to avoid accidentally adding unencrypted files with [git-crypt](https://www.agwa.name/projects/git-crypt/)
# Fix to [Issue #45](https://github.com/AGWA/git-crypt/issues/45)
#
# Usage:
#    $> cd /path/to/repository
#    $> git-crypt init
#    $> curl <url/to/this/raw/gist> -o .git/hooks/pre-commit
#    $> chmod +x .git/hooks/pre-commit
#
# Otherwise, you might want to add it as a git submodule, using:
#    $> git submodule add https://gist.github.com/848c82daa63710b6c132bb42029b30ef.git config/hooks/pre-commit.git-crypt
#    $> cd .git/hooks
#    $> ln -s ../../config/hooks/pre-commit.git-crypt/pre-commit.git-crypt.sh pre-commit
#

if [ -d .git-crypt ]; then
    STAGED_FILES=$(git diff --cached --name-status | awk '$1 != "D" { print $2 }' | xargs echo)
    if [ -n "${STAGED_FILES}" ]; then
        git-crypt status ${STAGED_FILES} &>/dev/null
        if [[ $? -ne 0  ]]; then
            git-crypt status -e ${STAGED_FILES}
            echo '/!\ You should have first unlocked your repository BEFORE staging the above file(s)'
            echo '/!\ Proceed now as follows:'
            echo -e "\t git unstage ${STAGED_FILES}"
            echo -e "\t git crypt unlock"
            echo -e "\t git add ${STAGED_FILES}"
            exit 1
        fi
    fi
fi
