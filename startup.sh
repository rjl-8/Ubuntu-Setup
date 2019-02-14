# do general app upgrades
sudo apt-get update
sudo apt-get -y upgrade

# install stuff I need
sudo apt-get -y install git
sudo apt-get -y install apache2
sudo apt-get -y install libapache2-mod-wsgi
sudo apt-get -y install mysql-server
# these don't work
#echo "mysql-server mysql-server/root_password password strangehat" | sudo debconf-set-selections
#echo "mysql-server mysql-server/root_password_again password strangehat" | sudo debconf-set-selections
#sudo mysql_secure_installation
#sudo apt install mysql-client-core-5.7
sudo service mysql stop
sudo vi /etc/mysql/mysql.conf.d/mysql.cnf
# add following
[mysqld]
# For debugging and recovery only #
skip-grant-tables
skip-networking
###################################
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

# download helpful files from git
git clone https://github.com/rjl-8/Ubuntu-Setup.git

# setup ssh (don't forget to do the firewall via the lightsail manage function)
chmod a+x ~/Ubuntu-Setup/secure_ssh.sh
~/Ubuntu-Setup/secure_ssh.sh > ~/Ubuntu-Setup/ssh_config.new
sudo cp /etc/ssh/sshd_config ~/Ubuntu-Setup/sshd_config.bak
sudo cp ~/Ubuntu-Setup/sshd_config.new /etc/ssh/sshd_config
sudo chown root:root /etc/ssh/sshd_config
sudo chmod a+r /etc/ssh/sshd_config
sudo chmod u+w /etc/ssh/sshd_config

echo 'Configure lightsail firewall to allow it'
echo 'in aws console, select lightsail'
echo 'then select the vertical elipsis for the instance in question'
echo 'then select Manage'
echo 'then select Networking'
echo 'then add a Custom TCP opening for port 2200'
echo 'then remove ssh tcp opening for port 22'
sudo ufw default deny incoming
sudo ufw default allow outgoing
#sudo ufw allow ssh
sudo ufw allow 2200/tcp
sudo ufw allow www
sudo ufw allow ntp
sudo ufw enable

# install python tools
#sudo apt install python-pip
#sudo pip install sqlalchemy
#sudo pip install psycopg2-binary
#sudo pip install flask
#sudo pip install oauth2client
#sudo pip install requests

# restart stuff
sudo apache2ctl restart
sudo service ssh restart
