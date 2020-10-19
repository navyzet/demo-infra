variable "instance_count" {
  default = "3"
}

variable "vpcCIDRblock" {
  default = "10.100.0.0/16"
}

variable "instanceTenancy" {
  default = "default"
}

variable "dnsSupport" {
  default = true
}

variable "dnsHostNames" {
  default = true
}

variable "subnetCIDRblock" {
  default = "10.100.0.0/24"
}

variable "mapPublicIP" {
  default = true
}

variable "ingressCIDRblock" {
  type    = list
  default = ["0.0.0.0/0"]
}

variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}
