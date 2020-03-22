
# resource "google_compute_firewall" "allow_ssh" {  
#     name = "allow-ssh"
#     network = "default"

#     allow {
#         protocol = "tcp"
#         ports = ["22"]
#     }

#     source_ranges = ["${var.my_public_ipv4}/32"]
#     target_tags = ["${var.compute_instance_vnc_tag}"]
# }

data "google_compute_image" "my_image" {
  family  = "${var.compute_image_family}"
  project = "${var.compute_image_project}"
}

resource "google_compute_instance" "default" {
  count = 1
  # project      = "${var.project_id}"
  zone         = "${var.project_zone}"
  name         = "${var.compute_instance_name}-${count.index}"
  machine_type = "${var.compute_instance_machine_type}"

  tags = ["${var.compute_instance_vnc_tag}"]

# ${var.compute_instance_startup_script_docker_compose} ${var.compute_instance_startup_script_xfce_desktop} ${var.compute_instance_startup_script_ansible} ${var.compute_instance_startup_script_ansible_awx}

  metadata_startup_script = <<EOL
    sudo adduser ${var.username} --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password;
    echo "${var.username}:${var.password}" | sudo chpasswd;
    sudo usermod -aG sudo ${var.username};
    sudo mkdir /home/${var.username}/.ssh;
    sudo chmod 777 /home/${var.username}/.ssh;
    sudo touch /home/${var.username}/.ssh/authorized_keys;
    sudo chmod 777 /home/${var.username}/.ssh/authorized_keys;
    sudo echo ${file("~/.ssh/${var.key_file_name}.pub")} >> /home/${var.username}/.ssh/authorized_keys;
    sudo chmod -R go= /home/${var.username}/.ssh;
    sudo chown -R ${var.username}:${var.username} /home/${var.username}/.ssh;
  EOL
    
  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.my_image.self_link}"
      size = "${var.compute_image_disk_size_gb}"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  provisioner "remote-exec" {
    connection {
      host        = "${self.network_interface[0].access_config[0].nat_ip}"
      type        = "ssh"
      user        = "${var.username}"
      timeout     = "150s"
      private_key = "${file("~/.ssh/${var.key_file_name}")}"
    }

    inline = "${concat(
      ["echo ${var.password} | sudo -S echo hello"],
      var.compute_instance_startup_script_docker,
      var.compute_instance_startup_script_docker_compose,
      var.compute_instance_startup_script_xfce_desktop
    )}"
  }
}