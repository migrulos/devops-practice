provider "google" {
    version = "2.7"
    project = "${var.project}"
    region = "europe-west1"
}

resource "google_compute_instance" "example-instance" {
    name    = "example-name"
    machine_type = "f1-micro"
    zone = "europe-west1-b"
    boot_disk {
        initialize_params {
            image = "centos-7"
        }
    }
    metadata = {
        sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
    }

network_interface {
    network = "default"
    access_config {}
}
}
