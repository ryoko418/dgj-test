# Terraform Provider

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.iam_user_ocid
  fingerprint      = var.iam_user_fingerprint
  private_key_path = var.iam_user_private_key_path
  region           = var.region
}


