node 'one.cluster' {  
    include ntp
    include hosts
    class { 'firewall': ensure=> 'stopped'}
    
    class { '::cloudera':
      cm_server_host   => 'one.cluster',
     install_cmserver => true
   }
}

node 'two.cluster' {  
   include ntp
   include hosts
   class { 'firewall': ensure=> 'stopped'}

   class { '::cloudera':
     cm_server_host => 'one.cluster'
   }
}
node 'three.cluster' {  
   include ntp
   include hosts
   class { 'firewall': ensure=> 'stopped'}

   class { '::cloudera':
     cm_server_host => 'one.cluster'
   }
}
