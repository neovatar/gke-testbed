data "template_file" "kubectl_config" {
  template = "${file("${path.module}/templates/kubeconfig-template.yaml")}"
  vars {
    cluster_endpoint = "${google_container_cluster.gke.endpoint}"
    cluster_auth_base64 = "${google_container_cluster.gke.master_auth.0.cluster_ca_certificate}"
    cluster_name = "${var.cluster_name}"
  }
}

resource "local_file" "kubectl_config" {
  content = "${data.template_file.kubectl_config.rendered}"
  filename = "yaml/kubeconfig.yaml"
}
