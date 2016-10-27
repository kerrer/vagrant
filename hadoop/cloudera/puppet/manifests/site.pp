class  sshkey {
  file { '/root/.ssh':
    ensure => directory,
    path   => '/root/.ssh',
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }->
  file { '/root/.ssh/authorized_keys':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    source => '/vagrant/files/authorized_keys',
  }
}

node 'one.cluster' {  
   
    include ntp
    class { 'firewall': ensure=> 'stopped'}
    
    class { '::cloudera':
      cm_server_host   => 'one.cluster',
     install_cmserver => true
   }
}

node 'two.cluster' {  
   include ntp
   class { 'firewall': ensure=> 'stopped'}

   class { '::cloudera':
     cm_server_host => 'one.cluster',
     use_parcels    => true
   }
}
node 'three.cluster' {  
   include ntp
   class { 'firewall': ensure=> 'stopped'}

   class { '::cloudera':
     cm_server_host => 'one.cluster'
   }
}

node 'four.cluster' {  
   include ntp
   class { 'firewall': ensure=> 'stopped'}

   include sshkey

  class { 'ssh::server':
   storeconfigs_enabled => false,
   options => {
      'PasswordAuthentication' => 'no',
      'PubkeyAuthentication'   => 'yes',
      'PermitRootLogin'        => 'yes'
   },
  }

  class { 'ssh::client':
      storeconfigs_enabled => false,
      options => {
        'Host *' => {
          'SendEnv'  => 'LANG LC_*',
          'HashKnownHosts' => 'yes',
          'GSSAPIAuthentication' => 'yes',
          'GSSAPIDelegateCredentials' => 'no',
          'StrictHostKeyChecking' => 'no',
        },
      },
    }
}
