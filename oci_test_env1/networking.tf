# Networking Resource

# For Service Gateway destination target service name, this code from github examples.
# https://github.com/terraform-providers/terraform-provider-oci/blob/master/examples/networking/service_gateway/service_gateway.tf
data "oci_core_services" "sgw_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

#Output data from above as services
output "services" {
  value = ["${data.oci_core_services.sgw_services.services}"]
}

resource oci_core_vcn export_VCN1 {
  cidr_block     = "10.0.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${upper(var.oci_resource_prefix)}-VCN1"
  dns_label      = "${lower(var.oci_resource_prefix)}vcn1"
}

resource oci_core_internet_gateway export_IGW1 {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${upper(var.oci_resource_prefix)}-IGW1"
  enabled        = "true"
  vcn_id         = "${oci_core_vcn.export_VCN1.id}"
}

resource oci_core_nat_gateway export_NATGW1 {
  block_traffic  = "false"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${upper(var.oci_resource_prefix)}-NATGW1"
  vcn_id         = "${oci_core_vcn.export_VCN1.id}"
}

resource oci_core_service_gateway export_SGW1 {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${upper(var.oci_resource_prefix)}-SGW1"
  # Get the service id dynamically. this code from github examples.
  services {
    service_id = "${lookup(data.oci_core_services.sgw_services.services[0], "id")}"
  }
  vcn_id = "${oci_core_vcn.export_VCN1.id}"
}

resource oci_core_route_table export_PUB-RTTBL1 {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${upper(var.oci_resource_prefix)}-PUB-RTTBL1"
  route_rules {
    description       = "Internet Gateway Attach to Public Subnet"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.export_IGW1.id}"
  }
  vcn_id = "${oci_core_vcn.export_VCN1.id}"
}

resource oci_core_route_table export_PRV-RTTBL2 {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${upper(var.oci_resource_prefix)}-PRV-RTTBL2"
  route_rules {
    description       = "Private to Oracle Service"
    # Get the service name dynamically. this code from github examples.
    destination       = "${lookup(data.oci_core_services.sgw_services.services[0], "cidr_block")}"
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = "${oci_core_service_gateway.export_SGW1.id}"
  }
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_nat_gateway.export_NATGW1.id}"
  }
  vcn_id = "${oci_core_vcn.export_VCN1.id}"
}

resource oci_core_security_list export_PUB-SECLST1 {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${upper(var.oci_resource_prefix)}-PUB-SECLST1"
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
    }
  }
  vcn_id = "${oci_core_vcn.export_VCN1.id}"
}

resource oci_core_security_list export_PRV-SECLST2 {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${upper(var.oci_resource_prefix)}-PRV-SECLST2"
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  ingress_security_rules {
    source      = "10.0.0.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
    }
  }
  vcn_id = "${oci_core_vcn.export_VCN1.id}"
}

resource oci_core_subnet export_PUB-SUBNET1 {
  #availability_domain = <<Optional value not found in discovery>>
  #If availability_domain is not specified, it becomes a Regional Subnet.
  cidr_block                 = "10.0.0.0/24"
  compartment_id             = "${var.compartment_ocid}"
  display_name               = "${upper(var.oci_resource_prefix)}-PUB-SUBNET1"
  dns_label                  = "${lower(var.oci_resource_prefix)}pubsubnet1"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = "${oci_core_route_table.export_PUB-RTTBL1.id}"
  security_list_ids = [
    "${oci_core_security_list.export_PUB-SECLST1.id}",
  ]
  vcn_id = "${oci_core_vcn.export_VCN1.id}"
}

resource oci_core_subnet export_PRV-SUBNET2 {
  #availability_domain = <<Optional value not found in discovery>>
  #If availability_domain is not specified, it becomes a Regional Subnet.
  cidr_block                 = "10.0.1.0/24"
  compartment_id             = "${var.compartment_ocid}"
  display_name               = "${upper(var.oci_resource_prefix)}-PRV-SUBNET2"
  dns_label                  = "${lower(var.oci_resource_prefix)}prvsubnet2"
  prohibit_public_ip_on_vnic = "true"
  route_table_id             = "${oci_core_route_table.export_PRV-RTTBL2.id}"
  security_list_ids = [
    "${oci_core_security_list.export_PRV-SECLST2.id}",
  ]
  vcn_id = "${oci_core_vcn.export_VCN1.id}"
}


