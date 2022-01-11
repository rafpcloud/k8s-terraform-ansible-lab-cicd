terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.71.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  shared_credentials_file = "/home/pacheco/.aws/credentials"
}



#terraform {
#  backend "s3" {
#  bucket       =  "buckpac12345"
#  key          = "terraform.tfstate"
#  region       = "us-east-1"
#  dynamodb_table = "terraform_state"
#  }
#}

