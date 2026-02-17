data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}


resource "yandex_compute_instance" "lendy" {
  count = 1

  name = "lendy-${count.index + 1}"
  hostname = "lendy-${count.index + 1}"

  resources {
    memory        = 2
    cores         = 2
  }

  boot_disk {
    initialize_params {
      name       = "disk-lendy-${count.index + 1}"
      type       = "network-ssd"
      size       = 10
      block_size = 4096
      image_id   = data.yandex_compute_image.ubuntu.id
    }
    auto_delete = true
  }

  # folder_id = "b1gdfsq84al32hk568ka"


  network_interface {
    subnet_id = "e2l7q23d0jq5as51sesr"
    nat       = true  
  }


  metadata = {
    user-data = file("users.yaml")
    ssh-keys  = <<-EOT
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPExEGlnItCDH8O+qVcbdOjtnk4UxQ7DhTtXys76gzLU lendy@fedora 
    EOT
  }

  scheduling_policy {
    preemptible = true
  }

  platform_id = "standard-v3"
  zone = "ru-central1-b"
}

# # 4. Security Group (SSH)
# resource "yandex_vpc_security_group" "ssh" {
#   name = "lendy-ssh"

#   egress {
#     protocol       = "ANY"
#     description    = "any"
#     from_port      = 0
#     to_port        = 65535
#     v4_cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     protocol       = "TCP"
#     description    = "SSH"
#     from_port      = 22
#     to_port        = 22
#     v4_cidr_blocks = ["0.0.0.0/0"] 
#   }
# }

# # 5. Outputs
# output "vm_ips" {
#   value = [for vm in yandex_compute_instance.lendy : 
#     "${vm.network_interface[0].nat_ip_address} (lendy-${vm.name})"
#   ]
# }


# data "yandex_compute_image" "ubuntu" {
#   family = "ubuntu-2204-lts"
# }


# resource "yandex_compute_disk" "boot-disk-1" {
#   count = 2

#   name     = "disk-ubuntu-lendy-${count.index}"
#   type     = "network-ssd"
#   zone     = "ru-central1-b"
#   size     = 10
#   image_id = data.yandex_compute_image.ubuntu.id 
# }

# resource "yandex_vpc_network" "network-1" {
#   name           = "network-1"
# }

# resource "yandex_vpc_subnet" "subnet-1" {
#   name           = "subnet-1"
#   zone           = "ru-central1-b"
#   network_id     = yandex_vpc_network.network-1.id
#   v4_cidr_blocks = ["192.168.10.0/24"]
# }


# resource "yandex_compute_instance" "lendy" {
#   count = 2

#   name        = "terraform1-${count.index}"
#   platform_id = "standard-v3"

#   resources {
#     memory = 1
#     cores  = 2
#   }

#   boot_disk {
#     disk_id = yandex_compute_disk.boot-disk-1[count.index].id
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.subnet-1.id
#     nat       = true
#   }

#   metadata = {
#     user-data = file("users.yaml")
#   }

#   scheduling_policy {
#     preemptible = true
#   }

#   zone = "ru-central1-b"
# }


# output "internal_ip_address_vm_1" {
#   value = yandex_compute_instance.lendy[0].network_interface[0].ip_address
# }

# output "external_ip_address_vm_1" {
#   value = yandex_compute_instance.lendy[0].network_interface[0].nat_ip_address
# }


# output "internal_ip_address_vm_2" {
#   value       = yandex_compute_instance.vm-2.network_interface.0.ip_address
# }

# output "internal_ip_address_vm_2" {
#   value       = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
# }





# resource "yandex_compute_disk" "boot-disk-1" {
#   count = 2
#   name       = "disk-ubuntu-lendy"
#   type       = "network-hdd"
#   zone       = "ru-central1-d"
#   size       = 10
#   image_id   = 
# }

# created network and subnet
# resource "yandex_vpc_network" "network" {
#   name = "lendy-network"
# }

# resource "yandex_vpc_subnet" "subnet" {
#   name           = "lendy-subnet"
#   zone           = "ru-central1-b"
#   network_id     = yandex_vpc_network.network.id
#   v4_cidr_blocks = ["192.168.10.0/24"]
# }