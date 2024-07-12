# 1. What is this?
This is terraform examples for OCI(Oracle Cloud Infrastructure) test environments.  
Display the list of Availability Domains. Does not create the resource.

# 2. Pre-requirements
* Terraform installation.
* Compartment creation.
* Create SSH pem-format key pairs(*.pub, *.pem) for IAM Users. Like following command.
```
openssl genrsa -out oci-terraform.pem 2048
openssl rsa -pubout -in oci-terraform.pem -out oci-terraform_pub.pem
```
* Create IAM User, Group, Policy in OCI console, Give users enough privileges(policy) like following.
```
ALLOW GROUP ays-iam-group01 TO manage all-resources IN compartment ays-compartment01
```
* Generate an API fingerprint for an IAM user. Paste the pem-format public key on the IAM User screen in the OCI Console.

# 3. Hot to use
## (1). Clone or Download this directory and files.
```
git clone https://github.com/gonsuke777/terraform
```

## (2). Edit variables(vars.tf).  
* tenancy_ocid ... Tenancy OCID, get from OCI console at tenancy.  
* iam_user_ocid ... IAM User OCID, get from OCI console at Users. This user was created in the Pre-requirements section.
* iam_user_fingerprint ... IAM User API fingerprint, get from OCI console at Users. This fingerprint was created in the Pre-requirements section. 
* iam_user_private_key_path ... The file path of the pem-format private key. This file is key pair of IAM User API fingerprint.
* region ... OCI region. For examples, ap-tokyo-1, us-phoenix-1, etc...
* compartment_ocid ... Compartment OCID, get from OCI console at compartment.

## (3). Terraform init, plan and apply.
```
cd <*.tf file directory>
terraform init
terraform plan
terraform apply
```

