# Compute Instance

resource oci_core_instance export_BASTION1 {
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${upper(var.oci_resource_prefix)}-BASTION1"
  # This code from https://www.terraform.io/docs/providers/oci/guides/best_practices.html
  # It to get a single AD name based on the index:
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[var.public_compute_ad_num - 1], "name")}"
  shape               = "VM.Standard.E2.1"
  source_details {
    source_type = "image"
    source_id   = "${var.os_image_source_id}"
  }
  create_vnic_details {
    assign_public_ip = "true"
    hostname_label   = "${lower(var.oci_resource_prefix)}-bastion1"
    subnet_id        = "${oci_core_subnet.export_PUB-SUBNET1.id}"
  }
  metadata = {
    ssh_authorized_keys = "${file(var.public_compute_ssh_key)}"
  }
}

resource oci_core_instance export_PRVCOMP1 {
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${upper(var.oci_resource_prefix)}-PRVCOMP1"
  # This code from https://www.terraform.io/docs/providers/oci/guides/best_practices.html
  # It to get a single AD name based on the index:
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[var.private_compute_ad_num - 1], "name")}"
  shape               = "VM.Standard.E2.1"
  source_details {
    source_type = "image"
    source_id   = "${var.os_image_source_id}"
  }
  create_vnic_details {
    assign_public_ip = "false"
    hostname_label   = "${lower(var.oci_resource_prefix)}-prvcomp1"
    subnet_id        = "${oci_core_subnet.export_PRV-SUBNET2.id}"
  }
  metadata = {
    ssh_authorized_keys = "${file(var.private_compute_ssh_key)}"
  }
}

