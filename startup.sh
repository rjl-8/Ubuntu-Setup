# do general app upgrades
sudo apt-get update
sudo apt-get upgrade

# install stuff I need
sudo apt-get install git
sudo apt-get install apache2
sudo apt-get install libapache2-mod-wsgi
sudo apt install mysql-client-core-5.7

# download helpful files from git
git clone https://github.com/rjl-8/Ubuntu-Setup.git

# setup ssh (don't forget to do the firewall via the lightsail manage function)
sudo cp /etc/ssh/sshd_config Ubuntu-Setup/sshd_config.bak
sudo cp Ubuntu-Setup/sshd_config /etc/ssh/sshd_config
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
