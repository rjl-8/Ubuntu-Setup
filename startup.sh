#Static ip - 18.188.43.43
#

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install git
sudo apt-get install apache2
sudo apt-get install libapache2-mod-wsgi
sudo apt install mysql-client-core-5.7

git clone https://github.com/rjl-8/Ubuntu-Setup.git
sudo cp /etc/ssh/sshd_config Ubuntu-Setup/sshd_config.bak
sudo cp Ubuntu-Setup/sshd_config /etc/ssh/sshd_config

#sudo apt install python-pip
#sudo pip install sqlalchemy
#sudo pip install psycopg2-binary
#sudo pip install flask
#sudo pip install oauth2client
#sudo pip install requests

sudo apache2ctl restart

sudo service ssh restart
