output "public_ip" {
  value = oci_core_instance.compute.public_ip
}
output "ssh_key" {
  value = tls_private_key.ssh.private_key_pem
}
