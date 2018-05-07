#!/bin/bash

__mysql_config() {
# Hack to get MySQL up and running... I need to look into it more.
echo "Running the mysql_config function."

rm -rf /var/lib/mysql/ /etc/my.cnf
mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/bin/mysqld_safe &
sleep 10
}

__start_mysql() {
echo "Running the start_mysql function."
mysqladmin -u root password mariadbPassword
mysql -uroot -pmariadbPassword -e "CREATE DATABASE testdb"
mysql -uroot -pmariadbPassword -e "GRANT ALL PRIVILEGES ON testdb.* TO 'testdb'@'localhost' IDENTIFIED BY 'mariadbPassword'; FLUSH PRIVILEGES;"
mysql -uroot -pmariadbPassword -e "GRANT ALL PRIVILEGES ON *.* TO 'testdb'@'%' IDENTIFIED BY 'mariadbPassword' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -uroot -pmariadbPassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'mariadbPassword' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -uroot -pmariadbPassword -e "CREATE USER 'frontend'@'%' IDENTIFIED BY 'mariadbPassword'; FLUSH PRIVILEGES;"
mysql -uroot -pmariadbPassword -e "CREATE DATABASE myDB;"
mysql -uroot -pmariadbPassword -e "GRANT ALL PRIVILEGES ON myDB.* TO 'frontend'@'%' IDENTIFIED BY 'mariadbPassword'; FLUSH PRIVILEGES;"
mysql -uroot -pmariadbPassword -e "select user, host FROM mysql.user;"

mysql -uroot -pmariadbPassword -e "use myDB; CREATE TABLE MyGuests (id int,firstname varchar(255),lastname varchar(255));"
mysql -uroot -pmariadbPassword -e "use myDB; INSERT INTO MyGuests VALUES (1, 'Robert', 'Brunne');"
mysql -uroot -pmariadbPassword -e "use myDB; INSERT INTO MyGuests VALUES (2, 'Shah', 'Zobair');"
sleep 10
}

# Call all functions
__mysql_config
__start_mysql
