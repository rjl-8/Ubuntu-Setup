cat /etc/ssh/sshd_config | awk '{
    if ($1 == "#Port") {
        print "Port 2200"
    }
    else if ($1 == "Port" && $2 != 2200) {
        print "Port 2200"
    }
    else if ($1 == "#PasswordAuthentication") {
        print "PasswordAuthentication no"
    }
    else if ($1 == "PasswordAuthentication" && $2 != "no") {
        print "PasswordAuthentication no"
    }
    else if ($1 == "#PermitRootLogin") {
        print "PermitRootLogin no"
    }
    else if ($1 == "PermitRootLogin" && $2 != "no") {
        print "PermitRootLogin no"
    }
    else {
        print $0
    }
}'
