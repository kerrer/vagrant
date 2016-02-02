#DUBBO
#
$zookeeper_version = '3.5.0-alpha'
node 'my1.max.com' {
class { 'jdk_oracle': 
     cache_source => "/all/"
   }
   class { 'supervisord':
    install_pip => true
   }->
  class {"lamp::nosql::redis::install":
    version =>"3.0.3"
  }->
  class  {"lamp::dsf::zookeeper::install": 
    version => $zookeeper_version
  }


   $tomcat7_home="/opt/apache-tomcat/tomcat7"
  class { 'tomcat': }
  tomcat::instance { 'tomcat7':
		catalina_base => $tomcat7_home,
		source_url  => '/all/apache-tomcat-7.0.63.tar.gz'
  }->
  tomcat::service { 'default': 
		catalina_base => $tomcat7_home,
		service_ensure => 'running',
  }
  
  
  
}


