provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.7"
}

terraform {
  required_version = ">= 0.12.20"

  backend "s3" {
    bucket  = "dm-vpc-states"
    key     = "dm_infra_cicd/iac_tf.tfstates"
    region  = "eu-west-1"
    encrypt = "true"
  }
}