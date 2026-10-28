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

variable "image" {
  type = string
  default = "ubuntu-2004-lts"  
}


### web_vars

variable "web_count" {
  type    = number
  default = 2
}

variable "vm_web_name" {
  type    = string
  default = "netology-develop-platform-web"
}

variable "vm_web_platform" {
  type    = string
  default = "standard-v4a"
}

variable "vm_web_preemptible" {
  type    = bool
  default = true
}

variable "vm_web_nat" {
  type    = bool
  default = true
}

### db_vars

variable "vm_db_name" {
  type    = string
  default = "netology-develop-platform-db"
}


variable "vm_db_preemptible" {
  type    = bool
  default = true
}

variable "vm_db_nat" {
  type    = bool
  default = true
}

### disk_vars

variable "disk_count" {
  type    = number
  default = 3
}

variable "disk_name" {
  type    = string
  default = "disk"
}

variable "disk_size" {
  type    = number
  default = 1
}

variable "disk_type" {
  type = string
  default = "network-ssd"
}

### storage_vars

variable "storage_count" {
  type    = number
  default = 1
}

variable "storage_name" {
  type = string
  default = "netology-develop-platform-storage"
}

variable "storage_platform" {
  type    = string
  default = "standard-v4a"
}

variable "storage_disk_type" {
  type = string
  default = "network-ssd"
}

variable "storage_preemptible" {
  type    = bool
  default = true
}

variable "storage_nat" {
  type    = bool
  default = true
}


### vms_resources

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
    storage = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}



variable "each_vm" {
  type = list(object({
    vm_name       = string
    platform_id   = string
    cpu           = number
    ram           = number
    core_fraction = number
    disk_volume   = number
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


