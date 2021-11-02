variable "project" {}

variable "credentials_file" {}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

variable "script_path" {
  description = "Path to the startup script."
  default     = "./startup.sh"
}
variable "public_key_path" {
  description = "Path to the public SSH key you want to bake into the instance."
  default     = "/root/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to the private SSH key, used to access the instance."
  default     = "/root/.ssh/id_rsa"
}

variable "ssh_user" {
  description = "SSH user name to connect to your instance."
  default     = "olegm"
}

