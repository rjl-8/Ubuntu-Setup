use mysql;
flush privileges;
update user set authentication_string=PASSWORD("Passw0rd") where User='root';
UPDATE user SET plugin="mysql_native_password" WHERE User='root';
quit
