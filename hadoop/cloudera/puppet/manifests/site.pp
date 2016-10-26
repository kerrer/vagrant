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
