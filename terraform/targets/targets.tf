# Get CloudInit user data info
data "template_file" "user_data" {
  template = file("${path.module}/../config/cloud_init.yml")
}

# Create Ansible target server profile
resource "lxd_profile" "server_config" {
  name        = "target_config"
  description = "target server LXC container"

  config = {
    "limits.cpu"           = 2
    "limits.memory"        = "2048MB"
    "user.vendor-data"     = data.template_file.user_data.rendered
  }
}

# Create storage pool
resource "lxd_storage_pool" "target" {
  name   = "target"
  driver = "dir"
  config = {
    source = "/var/snap/lxd/common/lxd/storage-pools/target"
  }
}

# Create storage volumes
resource "lxd_volume" "target" {
  for_each = var.instances
  name     = each.key
  pool     = "${lxd_storage_pool.target.name}"
}

# Create target containers
resource "lxd_container" "target" {
  for_each  = var.instances
  name      = "${each.value["prefix"]}${each.key}"
  image     = each.value["image"]
  ephemeral = false
  profiles  = ["default", lxd_profile.server_config.name]

  device {
    name = "volume1"
    type = "disk"
    properties = {
      path   = "/mnt/disk1"
      source = "${lxd_volume.target[each.key]["name"]}"
      pool   = "${lxd_storage_pool.target.name}"
    }
  }
}
