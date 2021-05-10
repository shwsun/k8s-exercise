#sudo wget --no-check-certificate https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo rpm -Uvh mysql80-community-release-el7-3.noarch.rpm
sudo yum install mysql-server
sudo systemctl start mysqld 

sudo grep 'password' /var/log/mysqld.log
# QbmuT6E/*>Hj
sudo mysql_secure_installation
# # 2201Tjs!00 
# mysql -u root -p

# CREATE DATABASE newdb;
# show databases;
# use newdb;
# CREATE USER 'shwsun'@'localhost' IDENTIFIED BY '2201Tjs!00'

# # to connect mysql with dbeaver
# # install dbeaver
# # downloa and copy mysql-connector in driver properties.
# mysql-connector-java-8.0.16.redhat-00001.jar  

CREATE USER 'root'@'%' identified by '2201Tjs!00';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;


# CREATE TABLE `student_tb` (
#     `sno` int(11) NOT NULL,
#     `name` char(10) DEFAULT NULL,
#     `det` char(20) DEFAULT NULL,
#     `addr` char(80) DEFAULT NULL,
#     `tel` char(20) DEFAULT NULL,
#     PRIMARY KEY (`sno`)
# ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# insert into student_tb values(1, 'name_a', 'det', 'addr', 'tel');
# 
# SELECT User, Host FROM mysql.user WHERE Host <> 'localhost';



# /etc/mysql/mysql.conf.d/mysqld.cnf
# mysqld --verbose --help | grep bind-address
# mysqld --verbose --help | grep -A 1 'Default options'
# mysqld --verbose --help | grep -A 1 'bind-address'
# find . -name 'mysqld.cnf'
# grep -Ril "bind-address" /

#systemctl restart mysqld
#systemctl stop mysqld
