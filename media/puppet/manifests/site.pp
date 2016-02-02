#RED5

$redis_cluster="connect"
$red5="1.0.5-RELEASE"
#$red5="1.0.6-SNAPSHOT"
$war="yxvedio-1.0.6.RELEASE.war"
$plugin_jar="red5-cluster-1.0.5.RELEASE.jar"
$nodes=['192.168.56.41','192.168.56.42','192.168.56.43','192.168.56.43']

node 'my1.max.com' {
   class { 'jdk_oracle': 
     cache_source => "/job/"
   }
  sysctl { 'fs.file-max': value => '100000' }
  class { 'supervisord':
   install_pip => true,
  }

  class {'lamp::cluster::red5':
      red5 => $red5,
      war  => $war,
      type =>"origin",
      plugin_jar=>$plugin_jar,
      require => Class['supervisord']
  }

  lamp::php::cli{"php5":
      debug => true,
   }
   ->
   lamp::apache2::install {"apache2":
      root=>"/job/web",
      hosts => [{"host"=>"wlyy.max.com","doc"=>"/sites/wlyy.yx129.com"}],
   }
   class {"lamp::nosql::redis::install":
    version =>"3.0.3"
    require => Class['supervisord']
  }

}

node 'my2.max.com' {
   class { 'supervisord':
      install_pip => true,
   }  
   class {'lamp::cluster::red5':
      red5 => $red5,
      war  => $war,
      type =>"edge",
      plugin_jar=>$plugin_jar,
      require => Class['supervisord']
   }

   class { 'jdk_oracle': }
   class {"lamp::cluster::redis": 
     version => "3.0.3",
     sentinel => true,
     nodes => $nodes,
    require => Class['supervisord']
  }
   
}

node 'my3.max.com' {
  class { 'supervisord':
   install_pip => true,
  }

  class {'lamp::cluster::red5':
      red5 => $red5,
      war  => $war,
      type =>"edge",
      plugin_jar=>$plugin_jar,
      require => Class['supervisord']
  }
  class { 'jdk_oracle': }
  class {"lamp::cluster::redis": 
     version => "3.0.3",
     sentinel => true,
     nodes => $nodes,
     require => Class['supervisord']
  }
}

node 'my4.max.com' {
  class { 'supervisord':
   install_pip => true,
  }

  class {'lamp::cluster::red5':
      red5 => $red5,
      war  => $war,
      type =>"edge",
      plugin_jar=>$plugin_jar,
      require => Class['supervisord']
  }
  class { 'jdk_oracle': }
  class {"lamp::cluster::redis": 
     version => "3.0.3",
     sentinel => true,
     nodes => $nodes,
     require => Class['supervisord']
  }
}
