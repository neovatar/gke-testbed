resource "google_container_cluster" "gke" {
  name               = "${var.cluster_name}"
  zone               = "europe-west3-a"
  remove_default_node_pool = true

  min_master_version = "1.11.2-gke.18"

  lifecycle {
    ignore_changes = ["node_pool"]
  }

  node_pool {
    name = "default-pool"
  }

  addons_config {
    kubernetes_dashboard {
      disabled = true
    }
  }

  # Disable static password authentication
  master_auth {
    username = ""
    password = ""
  }
}

resource "google_container_node_pool" "primary_pool" {
  name       = "primary-pool"
  cluster    = "${google_container_cluster.gke.name}"
  zone       = "europe-west3-a"
  node_count = "2"

  node_config {
    machine_type = "n1-standard-1"
  }
}
