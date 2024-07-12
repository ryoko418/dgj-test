# Object Storage

data oci_objectstorage_namespace export_ns {
  compartment_id = "${var.compartment_ocid}"
}

resource oci_objectstorage_bucket export_OBJSTR1 {
  access_type           = "NoPublicAccess"
  compartment_id        = "${var.compartment_ocid}"
  name                  = "${upper(var.oci_resource_prefix)}-OBJSTR1"
  namespace             = "${data.oci_objectstorage_namespace.export_ns.namespace}"
  object_events_enabled = "false"
  storage_tier          = "Standard"
  versioning            = "Disabled"
}

