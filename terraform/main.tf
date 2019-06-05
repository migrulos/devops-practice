provider "google" {
  version = "2.7"
  project = "${var.project}"
  region  = "europe-west1"
}

resource "google_compute_project_metadata" "ssh-keys" {
  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
}
