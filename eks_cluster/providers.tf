terraform {
  required_version = ">= 0.11.0"
}

provider "aws" {
   region  = var.region
  #  alias   = "primary"
    default_tags {
      tags = local.common_tags
    }
}
