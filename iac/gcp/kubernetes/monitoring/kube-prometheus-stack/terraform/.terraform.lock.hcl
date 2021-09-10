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

# This file is maintained automatically by "terraform init".
# Manual edits may be lost in future updates.

provider "registry.terraform.io/carlpett/sops" {
  version     = "0.6.0"
  constraints = "0.6.0"
  hashes = [
    "h1:YJCp4t6tEy7sr1QLuP9gsTR2Js+A/rRyJTWMfwVdxIk=",
    "zh:02c772f03a80135f1f0cdaff7f4a4da4edbb2963c1606b4a798d620f57822b25",
    "zh:04ea100f1094e52005938ba8512e469bb3212f6280bf462959b26395ea91e84b",
    "zh:3658a37fb76368c84f5690f176a2b7c73e23b18506030abb1884136e4ac6967f",
    "zh:564e1b306685f755904d25a8231d5a42b985856c8090d8e3f2fb906b080ad74b",
    "zh:ade14ab5b9b4314a9e0ce35150481459022e53641ce594358f2db1e449380aa6",
  ]
}

provider "registry.terraform.io/hashicorp/google" {
  version     = "3.83.0"
  constraints = "3.83.0"
  hashes = [
    "h1:1BcdezHZ8C3MokGYCssLgKL63ASumbXybj3Nt/1rqAk=",
    "h1:5d7PZksXgxIWwp9jz9WYDbX5n+muPnVyzD/EwJ0t5Ls=",
    "h1:NGs1B7FrEUKIM3Yw2RP9tso8FuHf4VhKY6lQ7EaxTFI=",
    "h1:VRH2G2X/z2QaLsj+jhDNNQLxMI0JFKIM8ljqAIJ/iqY=",
    "h1:cM7TTvxkqXVvsBenUHy3v+0pgVuT6qDpujIK9bvWVmE=",
    "h1:eeOAKqfjGWvF/oMht8kWse31C6xObnmrQXHH7d76hRw=",
    "h1:gba5Yl5l28t/M+vKuSWP96OpdqKVIdDW82OCMZcS1XY=",
    "h1:hDTuFInonXOAHxQyeHjGNJ2nHfMcYLK7rpVnPkLd+kQ=",
    "h1:oIBtoDXHXGZ5pOCUH/0MzubDgcq6Ny72xJg1JoX25/o=",
    "h1:ps3PVOYUUmXVNJQaQOmfLAFw/6h6CCnSFBYWp7+/ftE=",
    "h1:v3gFe1fMuX53P+pA+JORsPr298Z6Xk2NuZJt4xBFZP4=",
  ]
}

provider "registry.terraform.io/hashicorp/helm" {
  version     = "2.0.2"
  constraints = "2.0.2"
  hashes = [
    "h1:NeS94WlOI85mRXQblK/s1oGO/pdz+2HCAsQp8ePQqH0=",
    "zh:09f7b2389f0e41f51c933d014fe3a89aa53c12801ab45c082d3626689961d5a6",
    "zh:0af792512adf59648b7cb7f0f194151ac926ae6805ffdb2baf61512b55933e17",
    "zh:0e29837d65bf4dbe3b9766221a1a4448b2c9df7f4d3049a0b6812055e299c063",
    "zh:25a0c4d1cba9a22f4d12f6465f191db6e2ec675cbc2c7751bf128bcae23848a8",
    "zh:6d92f9ffd43a45f0f0da4c59cbb1790b163235882532a88344a53b8526808979",
    "zh:7c98a0e05f106d4bbfc0c81f7d8b41bc8e867a99b30ccd472367d0414e778c30",
    "zh:8de8232eedfa4ade990faea4ed3706f0846eb1d66fb82aa22718c7a9aeda92b1",
    "zh:baff5ff10c9573104d25eece9f79477112ed6882c0ea9280ecbfa944d117838d",
    "zh:d151fac8be471922cbe137f5a263f4854cdcfbf3fb8af7db83c709d64956934b",
    "zh:e4d238facc27fc91d26aef79b7f398a6b9f3a1fe078c8d3f0cd4df47ec5aaacd",
  ]
}

provider "registry.terraform.io/hashicorp/kubernetes" {
  version = "2.0.2"
  hashes = [
    "h1:PRfDnUFBD4ud7SgsMAa5S2Gd60FeriD1PWE6EifjXB0=",
    "zh:4e66d509c828b0a2e599a567ad470bf85ebada62788aead87a8fb621301dec55",
    "zh:55ca6466a82f60d2c9798d171edafacc9ea4991aa7aa32ed5d82d6831cf44542",
    "zh:65741e6910c8b1322d9aef5dda4d98d1e6409aebc5514b518f46019cd06e1b47",
    "zh:79456ca037c19983977285703f19f4b04f7eadcf8eb6af21f5ea615026271578",
    "zh:7c39ced4dc44181296721715005e390021770077012c206ab4c209fb704b34d0",
    "zh:86856c82a6444c19b3e3005e91408ac68eb010c9218c4c4119fc59300b107026",
    "zh:999865090c72fa9b85c45e76b20839da51714ae429d1ab14b7d8ce66c2655abf",
    "zh:a3ea0ae37c61b4bfe81f7a395fb7b5ba61564e7d716d7a191372c3c983271d13",
    "zh:d9061861822933ebb2765fa691aeed2930ee495bfb6f72a5bdd88f43ccd9e038",
    "zh:e04adbe0d5597d1fdd4f418be19c9df171f1d709009f63b8ce1239b71b4fa45a",
  ]
}
