resource "oci_identity_compartment" "tf-compartment" {
    # Required
    compartment_id = "ocid1.tenancy.oc1..aaaaaaaa6u76bpjwih24sphv3nkm7wb5negilj5c7yhduekfiem3t5einyha"
    description = "Compartment for Terraform resources."
    name = "github-test"
}
