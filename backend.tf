terraform {
  backend "s3" {
    bucket = "myreplicatbucket12"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynambodb_table = "mydp"
  }
}
