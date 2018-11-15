resource "google_storage_bucket" "terraform_state" {
  name     = "moonlit-oven-221217-tfstate"
  location = "europe-west3"

  force_destroy = true

  versioning {
    enabled = false
  }
}