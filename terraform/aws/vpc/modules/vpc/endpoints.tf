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

module "endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.11.0"

  vpc_id = module.vpc.vpc_id

  security_group_ids = [data.aws_security_group.default.id]

  endpoints = {
    s3 = {
      service      = "s3"
      service_type = "Gateway"
      route_table_ids = flatten([
        module.vpc.intra_route_table_ids,
        module.vpc.private_route_table_ids,
        module.vpc.public_route_table_ids
      ])
      tags = {
        Name = format("%s-s3", module.vpc.name)
      }
    },
    # dynamodb = {
    #   service         = "dynamodb"
    #   service_type    = "Gateway"
    #   route_table_ids = flatten([
    #     module.vpc.intra_route_table_ids,
    #     module.vpc.private_route_table_ids,
    #     module.vpc.public_route_table_ids
    #   ])
    #   tags = {
    #     Name = format("%s-dynamodb", module.vpc.name)
    #   }
    # }
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-ssm", module.vpc.name)
      }
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-ssmmessages", module.vpc.name)
      }
    },
    lambda = {
      service             = "lambda"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-lambda", module.vpc.name)
      }
    },
    ecs = {
      service             = "ecs"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-ecs", module.vpc.name)
      }
    },
    ecs_telemetry = {
      service             = "ecs-telemetry"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-ecs-telemetry", module.vpc.name)
      }
    },
    ec2 = {
      service             = "ec2"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-ec2", module.vpc.name)
      }
    },
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-ec2messages", module.vpc.name)
      }
    },
    # ecr_api = {
    #   service             = "ecr.api"
    #   private_dns_enabled = true
    #   subnet_ids          = module.vpc.private_subnets
    #   policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    #   tags = {
    #     Name = format("%s-ecr.api", module.vpc.name)
    #   }
    # },
    # ecr_dkr = {
    #   service             = "ecr.dkr"
    #   private_dns_enabled = true
    #   subnet_ids          = module.vpc.private_subnets
    #   policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    #   tags = {
    #     Name = format("%s-ecr.dkr", module.vpc.name)
    #   }
    # },
    kms = {
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-kms", module.vpc.name)
      }
    },
    sqs = {
      service             = "sqs"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-sqs", module.vpc.name)
      }
    },
    sns = {
      service             = "sns"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-sns", module.vpc.name)
      }
    },
    secretsmanager = {
      service             = "secretsmanager"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = format("%s-secretsmanager", module.vpc.name)
      }
    },
    # apigw = {
    #   service             = "apigw"
    #   service_type        = "Interface"
    #   private_dns_enabled = true
    #   subnet_ids          = module.vpc.private_subnets
    #   tags = {
    #     Name = format("%s-apigw", module.vpc.name)
    #   }
    # },
  }
}
