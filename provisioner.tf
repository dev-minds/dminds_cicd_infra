provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.7"
}

terraform {
  required_version = ">= 0.11.14"

  backend "s3" {
    bucket  = "dm-vpc-states"
    key     = "tf_ami_ci/ci.tfstates"
    region  = "eu-west-1"
    encrypt = "true"
  }
}  