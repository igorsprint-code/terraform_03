data "yandex_compute_image" "ubuntu" {
  family = var.image
}


resource "yandex_compute_instance" "web" {
  depends_on  = [yandex_compute_instance.db]
  count       = var.web_count
  name        = "${var.vm_web_name}-${count.index + 1}"
  platform_id = var.vm_web_platform
  hostname    = "${var.vm_web_name}-${count.index + 1}"
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_web_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = merge(var.metadata, {
    ssh-keys = "ubuntu:${local.ssh_public}"
  })

}