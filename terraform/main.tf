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

resource "google_compute_instance" "example-instance" {
  name         = "example-name"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"
  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }
  #    tags = ["open-5000tcp"]
  tags = ["http-server"]

  ### changed to project_metadata with "ssh-keys" instead of "sshKeys"
  #metadata = {
  #  sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  #}

  network_interface {
    network = "default"
    access_config {
        # Ephemeral ip
    }
  }

  metadata_startup_script = "${file("scripts/install-apache.sh")}"

  #    provisioner "local-exec" {
  #        inline = [
  #            "sudo /tmp/install-apache.sh"
  #        ]
  #    }

}

#resource "google_compute_firewall" "open-port-example" {
#    name = "open-port-example"
#    network = "default"
#    allow {
#        protocol = "tcp"
#        ports = ["5000"]
#    }
#    source_ranges = ["0.0.0.0/0"]
#    target_tags = ["open-5000tcp"]
#}
