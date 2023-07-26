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

#Install xDebug
sudo apt-get -y install php-xdebug

#Grant permissions
sudo chown -R $USER:$USER /var/www/
sudo chown -R $USER:$USER /etc/apache2/
sudo chmod -R 755 /var/www

# Change default virtual host settings
sudo a2enmod rewrite
sudo echo -e "<VirtualHost *:80>\n\tServerAdmin webmaster@localhost\n\tServerName time.test\n\t\n\tDocumentRoot /var/www/html\n\n\t<Directory /var/www/>\n\t\tOptions Indexes FollowSymLinks\n\t\tAllowOverride All\n\t\tRequire all granted\n\t</Directory>\n\tErrorLog \${APACHE_LOG_DIR}/error.log\n\tCustomLog \${APACHE_LOG_DIR}/access.log combined\n</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

# Xdebug
sudo cp /var/www/html/environment/xdebug.ini /etc/php/8.1/mods-available/

#Restart Apache to apply changes
sudo systemctl reload apache2