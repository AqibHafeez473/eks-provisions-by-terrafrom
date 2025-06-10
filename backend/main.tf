provider "aws" {
 region = "us-east-1"
}
resource "aws_s3_bucket" "terraform_s3" {
 bucket = "remote-backend-s3"
 lifecycle {
 prevent_destroy = false
 }
}
resource "aws_s3_bucket_versioning" "terraform_s3" {
     bucket = aws_s3_bucket.terraform_state.id
 versioning_configuration {
 status = "Enabled"
 }
}

resource "aws_dynamodb_table" "terraform_locks" {
 name = "remote-backend-locks"
 billing_mode = "PAY_PER_REQUEST"
 hash_key = "LockID"   
    attribute { 
    name = "LockID"
    type = "S"
    }
}

