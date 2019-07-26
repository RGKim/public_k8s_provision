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
resource "null_resource" "ibmcloud_login" {
    provisioner "local-exec" {
        command = <<-EOF
            ibmcloud login --apikey ${var.ibm_apikey}
            ibmcloud ks region-set ${var.region}
            ibmcloud ks cluster-config --cluster ${ibm_container_cluster.cluster.name}
            export KUBECONFIG=/Users/$USER/.bluemix/plugins/container-service/clusters/${ibm_container_cluster.cluster.name}/kube-config-${var.datacenter}-${ibm_container_cluster.cluster.name}.yml
            kubectl cluster-info
            kubectl create ns istio-system
            helm template helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -
            sleep 10
            kubectl get crds | grep 'istio.io\|certmanager.k8s.io' | wc -l
            sleep 30
            helm template helm/istio --name istio --namespace istio-system --values helm/istio/values-istio-demo.yaml | kubectl apply -f -
            # kubectl create serviceaccount tiller -n kube-system
            # kubectl create clusterrolebinding tiller --clusterrole=cluster-admin --serviceaccount=kube-system:tiller -n kube-system
            # helm init --service-account tiller
            # sleep 60
            # kubectl get pods -n kube-system -l app=helm
            # sleep 60
            # helm install zcp-istio/ -n istio --namespace istio-system
            # sleep 60
            # kubectl apply -f zcp-istio/telemetry/
            # kubectl get all -n istio-system
        EOF
    }
}

resource "random_id" "name" {
    byte_length = 4
}