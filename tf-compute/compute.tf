resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = "ocid1.compartment.oc1..aaaaaaaa7ydwfz2xkchs5cnt7ez5wqh6fl77osgwsddavkqw2mypvmh34txa"
    shape = "VM.Standard2.1"
    source_details {
        source_id = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaapq3vgnbcdemgidd3dqxiksyhrzlo3hzxvjedkdbfkwkk4x3hsaqa"
        source_type = "image"
    }

    # Optional
    display_name = "dg-test01"
    create_vnic_details {
        assign_public_ip = true
        subnet_id = "ocid1.subnet.oc1.ap-tokyo-1.aaaaaaaao6mqfpr4itrw4ap7lix7siil4wx7ribjqp4tfm3kmarskz2np44a"
    }
    metadata = {
        ssh_authorized_keys = file("../ssh/dg-test.pub")
    } 
    preserve_boot_volume = false
}
