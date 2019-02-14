use mysql;

flush privileges;
SET @query = CONCAT('update user set authentication_string=PASSWORD("', @pw, '") where User=''root'';');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE user SET plugin="mysql_native_password" WHERE User='root';
quit
