
$slaves = ['host1','host2','host3']
$hadoop_version = '2.7.1'
$spark_version = '1.4.0-bin-hadoop2.6'
$spark_master = '192.168.56.41'

node 'my1.max.com' {  
   class { 'jdk_oracle': }
   class {'lamp::cluster::ssh': }
   class {'lamp::cluster::hadoop': 
      version => $hadoop_version,
      slaves => $slaves
   }
   class {'lamp::cluster::spark':
      version => $spark_version,
      master => $spark_master,
      slaves => $slaves
   }
}

node 'my2.max.com' {  
    class { 'jdk_oracle': }
   class {'lamp::cluster::ssh': }
   class {'lamp::cluster::hadoop': 
      version => $hadoop_version,
      slaves => $slaves
   }
   class {'lamp::cluster::spark':
      version => $spark_version,
      master => $spark_master,
      slaves => $slaves
   }
}

node 'my3.max.com' {  
   class { 'jdk_oracle': }
   class {'lamp::cluster::ssh': }
   class {'lamp::cluster::hadoop': 
      version => $hadoop_version,
      slaves => $slaves
   }
   class {'lamp::cluster::spark':
      version => $spark_version,
      master => $spark_master,
      slaves => $slaves
   }
}
node 'my4.max.com' {  
   class { 'jdk_oracle': }
   class {'lamp::cluster::ssh': }
   class {'lamp::cluster::hadoop': 
      version => $hadoop_version,
      slaves => $slaves
   }
   class {'lamp::cluster::spark':
      version => $spark_version,
      master => $spark_master,
      slaves => $slaves
   }
}
