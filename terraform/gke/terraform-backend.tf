terraform {
  backend "gcs" {
    bucket  = "moonlit-oven-221217-tfstate"
    prefix  = "terraform/state/eks"
    region  = "europe-west3"
    project = "moonlit-oven-221217"
  }
}
