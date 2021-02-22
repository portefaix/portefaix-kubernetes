#!/usr/bin/python3

# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

from diagrams.aws import compute as compute_aws
from diagrams.aws import security as security_aws
from diagrams.aws import storage as storage_aws
from diagrams.azure import compute as compute_azure
from diagrams.azure import identity
from diagrams.azure import security as security_azure
from diagrams.azure import storage as storage_azure
from diagrams.gcp import compute as compute_gcp
from diagrams.gcp import devtools
from diagrams.gcp import security as security_gcp
from diagrams.gcp import storage as storage_gcp


def iam(cloud_provider, name="iam"):
    if cloud_provider == "gcp":
        iam = security_gcp.Iam(name)
    elif cloud_provider == "aws":
        iam = security_aws.IAM(name)
    elif cloud_provider == "azure":
        iam = identity.ManagedIdentities(name)
    return iam


def disk(cloud_provider, name=""):
    if cloud_provider == "gcp":
        disk = storage_gcp.PersistentDisk("disk")
    elif cloud_provider == "aws":
        disk = storage_aws.Storage("disk")
    elif cloud_provider == "azure":
        disk = storage_azure.GeneralStorage("disk")
    return disk


def compute(cloud_provider, name=""):
    compute = None
    if "aws" == cloud_provider:
        if name == "":
            name = "ec2"
        compute = compute_aws.EC2(name)
    elif "gcp" == cloud_provider:
        if name == "":
            name = "gce"
        compute = compute_gcp.ComputeEngine(name)
    elif "azure" == cloud_provider:
        if name == "":
            name = "az"
        compute = compute_azure.VMClassic()
    return compute


def kubernetes(cloud_provider, name=""):
    kubernetes = None
    if "aws" == cloud_provider:
        if name == "":
            name = "eks"
        kubernetes = compute_aws.ElasticKubernetesService(name)
    elif "gcp" == cloud_provider:
        if name == "":
            name = "gke"
        kubernetes = compute_gcp.KubernetesEngine(name)
    elif "azure" == cloud_provider:
        if name == "":
            name = "aks"
        kubernetes = compute_azure.KubernetesServices(name)
    return kubernetes


def container_registry(cloud_provider):
    registry = None
    if "aws" == cloud_provider:
        registry = compute_aws.EC2ContainerRegistry("ecr")
    elif "gcp" == cloud_provider:
        registry = devtools.ContainerRegistry("gcr")
    elif "azure" == cloud_provider:
        registry = compute_azure.ContainerRegistries("acr")
    return registry


def bucket(cloud_provider, name="bucket"):
    bucket = None
    if "aws" == cloud_provider:
        bucket = storage_aws.SimpleStorageServiceS3(name)
    elif "gcp" == cloud_provider:
        bucket = storage_gcp.Storage(name)
    elif "azure" == cloud_provider:
        bucket = storage_azure.StorageAccounts(name)
    return bucket


def kms(cloud_provider, name="kms"):
    kms = None
    if "aws" == cloud_provider:
        kms = security_aws.KeyManagementService(name)
    elif "gcp" == cloud_provider:
        kms = security_gcp.KeyManagementService(name)
    elif "azure" == cloud_provider:
        kms = security_azure.KeyVaults(name)
    return kms
