variable "instances" {
  description = "Dictionary of instance data. The instance name is the prefix value + the key"
  type = map(
    object(
      {
        prefix = string
        image  = string
      }
    )
  )
  default = {
    "01" = {
      prefix = "ansible-target-"
      image  = "ubuntu:22.04"
    }
    "02" = {
      prefix = "ansible-target-"
      image  = "images:debian/bookworm/cloud"
    }
    "03" = {
      prefix = "ansible-target-"
      image  = "images:alpine/3.16/cloud"
    }
  }
}
