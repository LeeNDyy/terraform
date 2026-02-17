variable "token" {
  description = "OAuth token"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
}
