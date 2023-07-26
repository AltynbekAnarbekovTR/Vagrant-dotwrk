#Install Apache web server
sudo apt-get update
sudo apt-get -y install  apache2

#Start Apache and set it to run at boot
sudo service apache2 start
sudo systemctl enable apache2

#Install php
sudo apt-get -y install php libapache2-mod-php

#Install MySQL
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server

#Make MySQL and  PHP friends
sudo apt-get -y install php-mysql

#Create folders
sudo mkdir /var/www/nsk.time
sudo mkdir /var/www/l-a.time

#Grant permissions
sudo chown -R $USER:$USER /var/www/
sudo chmod -R 755 /var/www

#Create PHP files with times
sudo echo "<?php date_default_timezone_set('Asia/Novosibirsk'); \$current_time = date('Y-m-d H:i:s'); echo 'Current time in Novosibirsk: ' . \$current_time;?>" > /var/www/nsk.timed/index.php
sudo echo "<?php date_default_timezone_set('America/Los_Angeles'); \$current_time = date('Y-m-d H:i:s'); echo 'Current time in Los Angeles: ' . \$current_time;?>" > /var/www/l-a.time/index.php

#Add Virtual Hosts
#sudo sed -i 's|/var/www/html|/var/www/nsk.time|g' /etc/apache2/sites-available/nsk.time.conf
#sudo a2ensite nsk.time.conf
# Копируем и включаем конфигурацию для сайта nsk.time.test
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/nsk.time.conf
sed -i '/ServerAdmin webmaster@localhost/a \    ServerName nsk.time.test' /etc/apache2/sites-available/nsk.time.conf
sudo sed -i 's|/var/www/html|/var/www/nsk.time|g' /etc/apache2/sites-available/nsk.time.conf
sudo a2ensite nsk.time.conf

# Копируем и включаем конфигурацию для сайта l-a.time.test
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/l-a.time.conf
sed -i '/ServerAdmin webmaster@localhost/a \    ServerName l-a.time.test' /etc/apache2/sites-available/l-a.time.conf
sudo sed -i 's|/var/www/html|/var/www/l-a.time|g' /etc/apache2/sites-available/l-a.time.conf
sudo a2ensite l-a.time.conf

# Disable default config
sudo a2dissite 000-default.conf

#Restart Apache to serve the new websites
sudo systemctl restart apache2

#Allow Override for .htaccess to work
#sudo sed -i 's/<Directory \/var\/www\/>/&\n    AllowOverride All/' /etc/apache2/apache2.conf
#sudo a2enmod rewrite