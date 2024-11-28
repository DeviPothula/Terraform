provider "aws" {
  region = "us-east-1"
  alias = "us-east-1"
}
provider "aws" {
  region = "us-west-1"
  alias = "us-west-1"
}
resource "aws_s3_bucket" "test-multi-region-east" {
  bucket = "test-multi-region-east"
  provider = aws.us-east-1
}
resource "aws_s3_bucket" "test-multi-region-west" {
  bucket = "test-multi-region-west"
  provider = aws.us-west-1
}