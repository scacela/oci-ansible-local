resource "oci_core_instance" "compute" {

  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
  compartment_id = var.compartment_ocid
  display_name   = "test-compute"
  shape          = var.instance_shape

  shape_config {
    ocpus = var.instance_ocpus
  }

  create_vnic_details {
    subnet_id        = var.subnet_ocid
    display_name     = "primary-vnic"
    assign_public_ip = true
    hostname_label   = "test-compute"
  }

  source_details {
    source_type = "image"
    source_id   = var.instance_image_ocid[var.region]
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.ssh.public_key_openssh
  }
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "null_resource" "compute_setup" {
  depends_on = [oci_core_instance.compute]

  # move the Ansible playbook folder to the compute
  provisioner "file" {
    source        = "playbooks"
    destination   = "/home/opc/"
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
  # move the run-ansible.sh file to the compute
  provisioner "file" {
    source      = "run-ansible.sh"
    destination = "/tmp/run-ansible.sh"
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
  # execute the run-ansible.sh file that is on the compute
  provisioner "remote-exec" {
    inline = [
      "chmod a+x /tmp/run-ansible.sh",
      "/tmp/run-ansible.sh"
      ]
    connection {
      host        = oci_core_instance.compute.public_ip
      type        = "ssh"
      user        = "opc"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }
  }

