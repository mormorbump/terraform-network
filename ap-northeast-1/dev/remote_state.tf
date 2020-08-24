data "terraform_remote_state" "common" {
  backend = "s3"

  config = {
    "bucket" = var.s3_remote_state_bucket
    "key"    = var.s3_remote_state_key # これはS3のkey
    "region" = var.region
  }
}
