###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-e"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vms_ssh_root_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMaMfRP37QFfTzysjQiIPsYlU78MBbr53uyxa0S5y1Cf igor@igor-VirtualBox"
}


variable "each_vm" {
  type = list(object({
    vm_name     = string
    platform_id = string
    cpu         = number
    ram         = number
    core_fraction = number
    disk_volume = number
  }))
  default = [
    { vm_name = "main", platform_id = "standard-v4a", cpu = 2, ram = 4, core_fraction = 20, disk_volume = 5 },
    { vm_name = "replica", platform_id = "standard-v4a", cpu = 2, ram = 2, core_fraction = 20, disk_volume = 5 }
  ]
}

variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = 1
  }
}


