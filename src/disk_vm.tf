resource "yandex_compute_disk" "storage_disk" {
  count = var.disk_count
  name  = "${var.disk_name}-${count.index + 1}"
  size  = var.disk_size
  type  = var.disk_type
  zone  = var.default_zone
}



resource "yandex_compute_instance" "storage" {
  name        = var.storage_name
  platform_id = var.storage_platform
  hostname    = var.storage_name
  resources {
    cores         = var.vms_resources["storage"].cores
    memory        = var.vms_resources["storage"].memory
    core_fraction = var.vms_resources["storage"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.storage_disk_type
    }
  }
  scheduling_policy {
    preemptible = var.storage_preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.storage_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk
    content {
      disk_id = secondary_disk.value.id
    }
  }

  metadata = merge(var.metadata, {
    ssh-keys = "ubuntu:${local.ssh_public}"
  })

}