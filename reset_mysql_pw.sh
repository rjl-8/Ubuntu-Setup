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
sudo chmod u+w /tmp/mysqld.cnf
sudo chown root:root /tmp/mysqld.cnf
sudo cp /tmp/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql start

mysql -e "set @pw='$1'; source=~/Ubuntu-Setup/reset_mysql_pw.sql"

sudo service mysql stop

cat /etc/mysql/mysql.conf.d/mysqld.cnf | awk '{
    if ($1 == "skip-grant-tables") {
        print "#skip-grant-tables"
    }
    else if ($1 == "skip-networking") {
        print "#skip-networking"
    }
    else {
        print $0
    }
}' > /tmp/mysqld.cnf
sudo chmod a+r /tmp/mysqld.cnf
sudo chmod u+w /tmp/mysqld.cnf
sudo chown root:root /tmp/mysqld.cnf
sudo cp /tmp/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql start
