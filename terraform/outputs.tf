output "external_ip" {
  value = "${google_compute_instance.example-instance.*.network_interface.0.access_config.0.nat_ip}"
} 

output "www-add" {
    value = "${google_compute_global_address.www.address}"
}
