/* 
--------------------------------------------------
      START -- GOOGLE PROJECT
--------------------------------------------------
*/ 
project_name = "test-004"

project_id = "test-004-30cb1610"

project_region = "us-east1"

project_zone = "us-east1-c"

project_labels = {
  env = "test"
}
/* command to get billing account number: 
    gcloud beta billing accounts list --filter open=true
*/
project_billing_account = "01DA1E-2FB8F6-1B4AD4"
/* 
--------------------------------------------------
      END -- GOOGLE PROJECT
--------------------------------------------------
*/ 



/* 
--------------------------------------------------
      START -- GOOGLE STORAGE BUCKET
--------------------------------------------------
*/ 
gcs_name = "image-storage-3"

gcs_location = "US"
/* 
--------------------------------------------------
      END -- GOOGLE STORAGE BUCKET
--------------------------------------------------
*/ 



/* 
--------------------------------------------------
      START -- COMPUTE INSTANCE
--------------------------------------------------
*/ 
compute_instance_name = "tf-compute-2"

compute_instance_machine_type = "n1-standard-2"

compute_instance_vnc_tag = "vnc-server"

compute_instance_startup_script_docker = [
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo sh get-docker.sh"
]

compute_instance_startup_script_docker_compose = [
      "sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose"
]

compute_instance_startup_script_xfce_desktop = [
      "wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb", 
      "sudo apt update", 
      "sudo dpkg --install chrome-remote-desktop_current_amd64.deb", 
      "sudo apt install --assume-yes --fix-broken", 
      "DEBIAN_FRONTEND=noninteractive", 
      "sudo apt install --assume-yes xfce4 desktop-base", 
      "echo xfce4-session > ~/.chrome-remote-desktop-session", 
      "sudo apt install --assume-yes xscreensaver", 
      "sudo apt install --assume-yes firefox"
]

compute_instance_startup_script_tightvncserver = [
      "sudo apt install tightvncserver",
      
]

compute_instance_startup_script_ansible = [
      "sudo apt update && apt upgrade -y",
      "echo 'deb http://archive.ubuntu.com/ubuntu bionic main universe' >> /etc/apt/sources.list",
      "echo 'deb http://archive.ubuntu.com/ubuntu bionic-security main universe' >> /etc/apt/sources.list",
      "echo 'deb http://archive.ubuntu.com/ubuntu bionic-updates main universe' >> /etc/apt/sources.list",
      "sudo apt update",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y"
]

compute_instance_startup_script_ansible_awx = [
      "sudo apt install python-pip -y",
      "sudo pip install docker",
      "sudo pip install docker-compose",
      "sudo apt install nodejs npm -y",
      "sudo npm install npm --global",
      "git clone https://github.com/ansible/awx.git",
      "cd awx/installer",
      "sudo ansible-playbook -i inventory install.yml"
]

compute_instance_startup_script_visual_studio_code = [
      "sudo apt update",
      "sudo apt install software-properties-common apt-transport-https wget",
      "wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -",
      "sudo add-apt-repository 'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main'",
      "sudo apt update",
      "sudo apt install code"
]

/* 
--------------------------------------------------
      END -- COMPUTE INSTANCE
--------------------------------------------------
*/ 



/* 
--------------------------------------------------
      START -- COMPUTE IMAGE
--------------------------------------------------
*/ 
compute_image_family = "ubuntu-1804-lts"

compute_image_project = "gce-uefi-images"

compute_image_disk_size_gb = 200
/* 
--------------------------------------------------
      END -- COMPUTE IMAGE
--------------------------------------------------
*/ 


/* 
--------------------------------------------------
      START -- MISC
--------------------------------------------------
*/

my_public_ipv4 = "99.45.181.48"

/* 
--------------------------------------------------
      END -- MISC
--------------------------------------------------
*/