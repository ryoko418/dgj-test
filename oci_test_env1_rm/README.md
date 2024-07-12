# 1. What is this?
This is OCI Resource Manager examples for OCI(Oracle Cloud Infrastructure) test environments.  
Create the following resources.  
* Networking(VCN, Gateway, Route Table, Seculity List, Subnet)
* Object Storage
* Compute(Public and Private)

# 2. Hot to use
## (1). Clone or Download this directory and files.
```
git clone https://github.com/gonsuke777/terraform
```
Three directories are created: oci_init, oci_test_env1 and oci_test_env1_rm.  
Resource Manager uses oci_test_env1_rm.  

## (2). Edit Compute public key(zzzzzzzz.pub, yyyyyyyy.pub).   
Generate a key for compute and paste the public key into zzzzzzzz.pub and yyyyyyyy.pub.  
Please refer to the following OCI manual. The key file name can be changed.  
  
Creating a Key Pair  
https://docs.oracle.com/en-us/iaas/Content/GSG/Tasks/creatingkeys.htm  

## (3). Edit variables(vars.tf).  
* os_image_source_id ... Regional OS Image ID, this ID is different for each region. Look https://docs.cloud.oracle.com/iaas/images/
* public_compute_ssh_key, private_compute_ssh_key ... File name of ssh public key (*.pub).
* public_compute_ad_num, private_compute_ad_num ... This is the AD index to place the compute, 1 or 2 or 3. In case 1AD region, it is only 1.
* oci_resourcel_prefix ... Resource name prefix. Maximum 4 characters.

## (4). OCI Resource Manager, upload folder, and plan, apply.
Upload the folder to the OCI Resouce Manager Stack.  
The plan and apply of the Stack are successful, the resources is provisioned.  
  
Thanks. 
