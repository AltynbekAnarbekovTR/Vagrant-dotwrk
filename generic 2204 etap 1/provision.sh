#Version 1
# #Install Apache web server
# sudo apt update -y
# #sudo apt install -y httpd


# #Start Apache and set it to run at boot
# sudo systemctl start httpd
# sudo systemctl enable httpd

# #Create a sample index.html file
# sudo echo "<html><body><h1>Hello, world!</h1></body></html>" > /var/
# www/html/index.html

# #Restart Apache to serve the new index.html
# sudo systemctl restart httpd

#Version 2
#Install Apache web server
sudo apt-get update

#sudo apt-get update -y install vim
#sudo apt-get update -y install git
sudo apt-get -y install  apache2

#Start Apache and set it to run at boot
sudo service apache2 start
sudo systemctl enable apache2

#Install php
sudo apt-get -y install php libapache2-mod-php
#sudo apt-get -y install php-mcrypt

#Install MySQL
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server
#sudo msqladmin -uroot -proot create test_database

#Make MySQL and  PHP friends
sudo apt-get -y install php-mysql

#Create a sample index.html file
#sudo echo "<html><body><h1>Hello, world</h1></body></html>" > /var/www/html/index.html
#sudo echo "<html><body><h1>Project 1</h1></body></html>" > /var/www/html/project1/index.html
#sudo echo "<html><body><h1>Hello, world</h1></body></html>" > /var/www/html/index.html

#Create a sample php file
#sudo echo "<php? echo '<h1>This is PHP file</h1>';" > /var/www/html/index.php
#sudo echo "<php? echo '<h1>This is PHP file</h1>" > /var/www/html/index.php
sudo echo "<php? echo '<h1>This is second PHP file</h1>" > /var/www/html/file.php
(sudo echo "<?php \n
// Set the timezone to Novosibirsk \n
date_default_timezone_set('Asia/Novosibirsk'); \n
\n
// Get the current time in Novosibirsk \n
$current_time = date('Y-m-d H:i:s'); \n
\n
// Output the time \n
echo "Current time in Novosibirsk: $current_time"; \n
?>" > /var/www/html/file.php)
#Working one:
sudo echo "<?php date_default_timezone_set('Asia/Novosibirsk'); \$current_time = date('Y-m-d H:i:s'); echo 'Current time in Novosibirsk: ' . \$current_time;?>" > /var/www/html/file.php
#Further experiment
sudo echo "<?php date_default_timezone_set('Asia/Novosibirsk'); \$current_time = date('Y-m-d H:i:s'); echo 'Current time in Novosibirsk: \$current_time';?>" > /var/www/html/file.php

#Create folders
sudo mkdir /var/www/html/

#Create a PHP files with times

# cat <<EOF > /var/www/html/file.php \
# <?php \
# // Set the timezone to Novosibirsk \
# date_default_timezone_set('Asia/Novosibirsk'); \
# \
# // Get the current time in Novosibirsk \
# $current_time = date('Y-m-d H:i:s'); \
# \
# // Output the time \
# echo "Current time in Novosibirsk: \$current_time"; \
# ?> \
# EOF


#Restart Apache to serve the new index.html
sudo systemctl restart apache2


