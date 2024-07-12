# Variables

## Provider Variables
### tenant ocid
variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

### OCI region (ex:ap-tokyo-1, us-phoenix-1, etc...)
variable "region" {
  default = "ap-tokyo-1"
}

### Compartment OCID
variable "compartment_ocid" {
  description = "The compartment which resources will be created"
  default     = "ocid1.compartment.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

## Networking Variables
### Public Subnet - Security List Ingress Rule
variable "pub_subnet_seclst_ingress_rule" {
  description = "Describe the CIDR of the connection source (ex: your PC, etc..). If you want to allow from all networks, describe 0.0.0.0/0."
  default     = "xxx.xxx.xxx.xxx/xx"
}

## Compute Variables
### Regional OS Image ID, this ID is different for each region. Look https://docs.cloud.oracle.com/iaas/images/
variable "os_image_source_id" {
  description = "For OS Image Source ID, look https://docs.cloud.oracle.com/iaas/images/"
  default     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaqgqr35z52xjqh3nxinud7ixdft3dxdsescidrgeh2v5rp6dqfwea"
}

### Compute ssh key path(pub format)
variable "public_compute_ssh_key" {
  description = "Public Compute ssh key file (in pub format) path (.../.../<key_filename>)"
  default     = "./zzzzzzzz.pub"
}

variable "private_compute_ssh_key" {
  description = "Private Compute ssh key file (in pub format) path (.../.../<key_filename>)"
  default     = "./yyyyyyyy.pub"
}

### Compute Availability Domain(1 or 2 or 3)
variable "public_compute_ad_num" {
  description = "Public Compute Availability Domain Num(1 or 2 or 3)"
  default     = "1"
}

variable "private_compute_ad_num" {
  description = "Private Compute Availability Domain Num(1 or 2 or 3)"
  default     = "1"
}

## Resource Prefix
variable "oci_resource_prefix" {
  description = "The prefix of all the resources to be created. Maximum 4 characters."
  default     = "AYS"
}


