node 'control.max.com' {
  include ::openstack::role::controller
}

node 'storage.max.com' {
  include ::openstack::role::storage
}

node 'network.max.com' {
  include ::openstack::role::network
}

node /compute[0-9]+.max.com/ {
  include ::openstack::role::compute
}
