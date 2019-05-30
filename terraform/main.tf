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

resource "google_compute_global_address" "www" {
    name = "www-address"
}

resource "google_compute_global_forwarding_rule" "http" {
    name = "http-forwarding-rule"
    ip_address = "${google_compute_global_address.www.address}"
    target = "${google_compute_target_http_proxy.http_proxy.self_link}"
    port_range = "80"
}

resource "google_compute_target_http_proxy" "http_proxy" {
    name = "http-proxy"
    url_map = "${google_compute_url_map.default.self_link}"
}

resource "google_compute_url_map" "default" {
    name = "url-map"
    default_service = "${google_compute_backend_service.default.self_link}"
}

resource "google_compute_backend_service" "default" {
    name = "backend-service"
    backend {
        group = "${google_compute_instance_group.instance_group.self_link}"
    }
    health_checks = ["${google_compute_http_health_check.http-hc.self_link}"]
}

resource "google_compute_http_health_check" "http-hc" {
    name = "http-health-check"
    timeout_sec = 3
    check_interval_sec = 4
}

resource "google_compute_instance_group" "instance_group" {
    name = "instance-group"
    zone = "europe-west1-b"
    instances = "${google_compute_instance.example-instance.*.self_link}"
}

resource "google_compute_instance" "example-instance" {
  count        = 2
  name         = "example-name-${count.index}"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"
  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }
  #    tags = ["open-5000tcp"]
  tags = ["http-server"]
  
  scheduling {
      preemptible = true
      automatic_restart = false
    }

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
