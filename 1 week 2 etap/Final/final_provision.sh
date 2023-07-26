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

#Grant permissions
sudo chown -R $USER:$USER /var/www/
sudo chmod -R 755 /var/www

#Create PHP files with times
sudo echo "<?php date_default_timezone_set('Asia/Novosibirsk'); \$current_time = date('Y-m-d H:i:s'); echo 'Current time in Novosibirsk: ' . \$current_time;?>" > /var/www/html/nsk.php

sudo echo "<?php date_default_timezone_set('America/Los_Angeles'); \$current_time = date('Y-m-d H:i:s'); echo 'Current time in Los Angeles: ' . \$current_time;?>" > /var/www/html/l-a.php

#Create PHP file index.php which will do routing
echo -e "<?php\n// Получаем значение параметра city из запроса\n\$city = isset(\$_GET['city']) ? \$_GET['city'] : '';\n\n// В зависимости от значения параметра city, выводим местное время\nif (\$city === 'nsk') {\n    include \"nsk.php\";\n} elseif (\$city === 'l-a') {\n    include \"l-a.php\";\n} else {\n   include \"nsk.php\";\n}\n?>" > /var/www/html/index.php

#Create .htaccess file
echo -e "RewriteEngine On\nRewriteBase /\n\n# Правило для перенаправления на index.php, если url path пустой\nRewriteRule ^\$ index.php [L]\n\n# Правило для обработки запросов на nsk\nRewriteRule ^nsk\$ index.php?city=nsk [L]\n\n# Правило для обработки запросов на l-a\nRewriteRule ^l-a\$ index.php?city=l-a [L]\n\n# Правило для обработки запросов c любым текстом после base url\nRewriteRule ^.*$ index.php [L]" > /var/www/html/.htaccess

#Allow Override for .htaccess to work
# sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sudo a2enmod rewrite
sudo a2dissite 000-default.conf
sudo rm /etc/apache2/sites-available/000-default.conf
echo -e "<VirtualHost *:80>\n\tServerAdmin webmaster@localhost\n\tServerName time.test\n\t\n\tDocumentRoot /var/www/html\n\n\t<Directory /var/www/>\n\t\tOptions Indexes FollowSymLinks\n\t\tAllowOverride All\n\t\tRequire all granted\n\t</Directory>\n\tErrorLog \${APACHE_LOG_DIR}/error.log\n\tCustomLog \${APACHE_LOG_DIR}/access.log combined\n</VirtualHost>" > /etc/apache2/sites-available/000-default.conf
sudo a2ensite 000-default.conf
#<VirtualHost *:80>
#        ServerAdmin webmaster@localhost
#        DocumentRoot /var/www/html
#
#        <Directory /var/www/>
#                Options Indexes FollowSymLinks
#                AllowOverride All
#                Require all granted
#        </Directory>
#        ErrorLog ${APACHE_LOG_DIR}/error.log
#        CustomLog ${APACHE_LOG_DIR}/access.log combined
#</VirtualHost>


#Restart Apache to serve the new websites
sudo systemctl restart apache2