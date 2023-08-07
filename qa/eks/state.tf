terraform {
  required_version = "= 1.4.6"
  backend "s3" {
    bucket  = "skycityhub-tfstate"
    key     = "qa/eks/tfstate"
    encrypt = true
    region  = "eu-central-1"
  }
}
