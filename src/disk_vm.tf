resource "yandex_compute_disk" "my_disk" {
  count = 3
  name     = "disk_${count.index+1}"
  size = 1
  type     = "network-ssd"
  zone     = var.default_zone
}



resource "yandex_compute_instance" "storage" {
  count = 1
  name        = "netology-develop-platform-storage-${count.index + 1}"
  platform_id = "standard-v4a"
  hostname    = "storage-${count.index + 1}"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-ssd"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.my_disk
    content {
      disk_id = secondary_disk.value.id
    }
  }

  metadata = merge (var.metadata, {
    ssh-keys = "ubuntu:${local.ssh_public}"
  })

}