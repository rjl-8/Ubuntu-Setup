cat /etc/mysql/mysql.conf.d/mysql.cnf | awk 'BEGIN{fnd=0}{
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
}'
