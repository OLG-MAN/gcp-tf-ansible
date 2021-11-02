resource "google_compute_instance" "tfansible1" {
  name         = "terraform-ansible1"
  machine_type = "e2-medium"
  zone         = var.zone

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"

  }

  provisioner "remote-exec" {
    script = var.script_path

    connection {
      type         = "ssh"
      user         = var.ssh_user
      private_key  = file(var.private_key_path)
      host         = google_compute_instance.tfansible1.network_interface.0.access_config.0.nat_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${google_compute_instance.tfansible1.network_interface.0.access_config.0.nat_ip},' --extra-vars 'instance1_ip_addr=${google_compute_instance.tfansible1.network_interface.0.access_config.0.nat_ip}' --private-key ${var.private_key_path} ./debian1.yaml"
  }
}

resource "google_compute_instance" "tfansible2" {
  name         = "terraform-ansible2"
  machine_type = "e2-medium"
  zone         = var.zone

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"

  }

  provisioner "remote-exec" {
    script = var.script_path

    connection {
      type         = "ssh"
      user         = var.ssh_user
      private_key  = file(var.private_key_path)
      host         = google_compute_instance.tfansible2.network_interface.0.access_config.0.nat_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${google_compute_instance.tfansible2.network_interface.0.access_config.0.nat_ip},' --extra-vars 'instance2_ip_addr=${google_compute_instance.tfansible2.network_interface.0.access_config.0.nat_ip}' --private-key ${var.private_key_path} ./debian2.yaml"
  }

  depends_on = [google_compute_instance.tfansible1]
}

resource "google_compute_instance" "tfansible3" {
  name         = "terraform-ansible3"
  machine_type = "e2-medium"
  zone         = var.zone

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"

  }

  provisioner "remote-exec" {
    script = var.script_path

    connection {
      type         = "ssh"
      user         = var.ssh_user
      private_key  = file(var.private_key_path)
      host         = google_compute_instance.tfansible3.network_interface.0.access_config.0.nat_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${google_compute_instance.tfansible3.network_interface.0.access_config.0.nat_ip},' --extra-vars 'instance1_ip_addr=${google_compute_instance.tfansible1.network_interface.0.access_config.0.nat_ip} instance2_ip_addr=${google_compute_instance.tfansible2.network_interface.0.access_config.0.nat_ip}' --private-key ${var.private_key_path} ./lb.yaml"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${google_compute_instance.tfansible1.network_interface.0.access_config.0.nat_ip},' --extra-vars 'instance3_ip_addr=${google_compute_instance.tfansible3.network_interface.0.access_config.0.nat_ip}' --private-key ${var.private_key_path} ./finalize.yaml"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${google_compute_instance.tfansible2.network_interface.0.access_config.0.nat_ip},' --extra-vars 'instance3_ip_addr=${google_compute_instance.tfansible3.network_interface.0.access_config.0.nat_ip}' --private-key ${var.private_key_path} ./finalize.yaml"
  }

  depends_on = [google_compute_instance.tfansible2]
}
