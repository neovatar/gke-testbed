resource "google_container_cluster" "gke" {
  name               = "${var.cluster_name}"
  zone               = "europe-west3-a"
  remove_default_node_pool = true

  min_master_version = "1.11.6-gke.3"

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
    machine_type = "n1-standard-2"
    oauth_scopes = [    
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
}
