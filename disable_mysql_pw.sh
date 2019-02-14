sudo service mysql stop

cat /etc/mysql/mysql.conf.d/mysqld.cnf | awk 'BEGIN{fnd=0}{
    if ($1 == "[mysqld]" && fnd == 0) {
        print "#skipstuffdone"
        print $0
        print "# For debugging and recovery only #"
        print "skip-grant-tables"
        print "skip-networking"
        print "###################################"
    }
    else if ($1 == "#skipstuffdone") {
        fnd = 1
    }
    else {
        print $0
    }
}' > /tmp/mysqld.cnf
sudo chmod a+r /tmp/mysqld.cnf
sudo chown root:root /tmp/mysqld.cnf
sudo cp /tmp/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql start

mysql
mysql> use mysql;
mysql> flush privileges;
mysql> update user set authentication_string=PASSWORD("YOUR-NEW-ROOT-PASSWORD") where User='root';
mysql> UPDATE user SET plugin="mysql_native_password" WHERE User='root';
mysql> quit

sudo service mysql stop
sudo vi /etc/mysql/mysql.conf.d/mysql.cnf
# add following
[mysqld]
# For debugging and recovery only #
#skip-grant-tables
#skip-networking
###################################
sudo service mysql start
