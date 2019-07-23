provider "ibm" {
    ibmcloud_api_key    = "${var.ibm_apikey}"
    softlayer_username  = "${var.sl_username}"
    softlayer_api_key   = "${var.sl_apikey}"
}

resource "ibm_container_cluster" "cluster" {
    region            = "${var.region}"
    name              = "${var.cluster_name}${random_id.name.hex}"
    datacenter        = "${var.datacenter}"
    default_pool_size = 2
    machine_type      = "${var.machine_type}"
    hardware          = "${var.hardware}"
    kube_version      = "${var.kube_version}"
    public_vlan_id    = "${var.public_vlan_id}"
    private_vlan_id   = "${var.private_vlan_id}"
    lifecycle {
        ignore_changes = ["kube_version"]
        }
}

resource "random_id" "name" {
    byte_length = 4
}