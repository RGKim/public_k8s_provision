variable "ibm_apikey" {
    default = "lM4cvdeYUzB_mgD-qJbTj1F0MfJtzzZwjOXzpOgKZEj0"
}
variable "sl_username" {
    default = "IBM1365537"
}
variable "sl_apikey" {
    default = "457a135ddc4d34ac9678bda5321c88d5755b833c8a3ae72058f1bbea8e2c813a"
}

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
    default = "iks_zcp_test"
}

variable "kube_version" {
    default = "1.13.8"
}