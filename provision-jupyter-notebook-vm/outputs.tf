output "public-ip-vm" {
  value = google_compute_instance.vm-main.network_interface.0.access_config.0.nat_ip
}