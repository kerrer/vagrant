#!/usr/bin/env bash
if [ -f "/var/MariaDB_installed" ]; then
 exit 0
fi

touch /var/MariaDB_installed

export DEBIAN_FRONTEND=noninteractive
ROOT_PASS="mmmm"
debconf-set-selections <<< "mariadb-galera-server	mariadb-galera-server/root-pass password $ROOT_PASS"
debconf-set-selections <<< "mariadb-galera-server	mariadb-galera-server/root_password_again password $ROOT_PASS"

invoke-rc.d apparmor kill
update-rc.d -f apparmor remove

apt-get install -y software-properties-common

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db 
add-apt-repository 'deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu trusty main'

apt-get update
apt-get install -y  mariadb-galera-server
mysql -uroot  -e "SET PASSWORD = PASSWORD('$ROOT_PASS');"

exit 0
