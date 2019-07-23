variable "ibm_apikey" {}
variable "sl_username" {}
variable "sl_apikey" {}

variable "region" {
    default = "jp-tok"
}
variable "datacenter" {
    default = "seo01"
}
variable "machine_type" {
    default = "b3c.4x16"
}

variable "hardware" {
    default = "shared"
}

variable "private_vlan_id" {
    default = "2119047"
}

variable "public_vlan_id" {
    default = "2119045"
}

variable "cluster_name" {
    default = "iks_zcp_local"
}

variable "kube_version" {
    default = "1.13.8"
}