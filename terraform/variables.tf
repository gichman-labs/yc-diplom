variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Folder ID"
  type        = string
}

variable "default_zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "service_account_key_file" {
  description = "Path to service account authorized key JSON"
  type        = string
}

variable "admin_ipv4_cidr" {
  description = "IPv4 CIDR for public administrative access"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ssh_user" {
  description = "Linux user for SSH access to instances"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_file" {
  description = "Path to SSH public key file"
  type        = string
}