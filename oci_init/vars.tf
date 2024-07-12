# Variables

## Provider Variables
### tenant ocid
variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaa6u76bpjwih24sphv3nkm7wb5negilj5c7yhduekfiem3t5einyha"
}

### IAM User OCID
variable "iam_user_ocid" {
  default = "ocid1.user.oc1..aaaaaaaax6irowlzh5ga7taian23dnck4ojn3ecrqdivkmw2uzzgdtomn5lq" 
}

### API fingerprint of IAM User
variable "iam_user_fingerprint" {
  default = "2f:72:e4:4d:3f:f3:65:20:9c:e2:60:78:8e:ab:f0:2f"
}

### IAM User private key path(pair of API fingerprint)
variable "iam_user_private_key_path" {
  default = "/Users/furukiryouko/.oci/oci-key.pem"
}

## OCI region (ex:ap-tokyo-1, us-phoenix-1, etc...)
variable "region" {
  default = "ap-tokyo-1"
}

# Compartment OCID
variable "compartment_ocid" {
  description = "The compartment which resources will be created"
  default     = "ocid1.tenancy.oc1..aaaaaaaa6u76bpjwih24sphv3nkm7wb5negilj5c7yhduekfiem3t5einyha"
}


