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

#############################################################################
# ACK Controller

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "namespace" {
  description = "The K8s namespace for ACK Controller resources"
  type        = string
  default     = "ack-system"
}

variable "ack_eks_name" {
  type        = string
  description = "ACK EKS controller name"
  default     = "eks"
}

variable "services" {
  description = "ACK services deployed"
  type = list(object({
    name       = string
    policy_arn = string
  }))
  default = [
    {
      name       = "apigatewayv2"
      policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
    },
    {
      name       = "applicationautoscaling"
      policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    },
    {
      name       = "dynamodb"
      policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
    },
    {
      name       = "ec2"
      policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    },
    {
      name       = "ecr"
      policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
    },
    # {
    #   name       = "eks"
    #   policy_arn = "arn:aws:iam::aws:policy/" # TODO:
    # },
    {
      name       = "apigatewayv2"
      policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
    },
    {
      name       = "elasticache"
      policy_arn = "arn:aws:iam::aws:policy/AmazonElastiCacheFullAccess"
    },
    {
      name       = "kms"
      policy_arn = "arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser"
    },
    {
      name       = "lambda"
      policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
    },
    {
      name       = "mq"
      policy_arn = "arn:aws:iam::aws:policy/AmazonMQApiFullAccess"
    },
    {
      name       = "opensearchservice"
      policy_arn = "arn:aws:iam::aws:policy/AmazonOpenSearchServiceFullAccess"
    },
    {
      name       = "rds"
      policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
    },
    {
      name       = "s3"
      policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    },
    {
      name       = "sagemaker"
      policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
    },
    {
      name       = "sfn"
      policy_arn = "arn:aws:iam::aws:policy/AWSStepFunctionsFullAccess"
    },
    {
      name       = "sns"
      policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
    },
  ]
}
