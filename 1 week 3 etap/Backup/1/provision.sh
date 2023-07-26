sudo apt-get update
sudo apt-get install nginx php8.1-fpm php-curl -y

# sudo chown -R $USER:$USER /var/www/
sudo chown -R $USER:$USER /etc/nginx/

sudo nano /etc/nginx/sites-available/default

sudo ln -s /etc/nginx/sites-available/time.test /etc/nginx/sites-enabled/

# sudo echo -e 'server {\n    listen 80;\n    server_name test.time;\n\n    location /nsk {\n        try_files $uri $uri/ /index.php?url=nsk;\n    }\n\n    location /l-a {\n        try_files $uri $uri/ /index.php?url=l-a;\n    }\n\n    location / {\n        try_files $uri $uri/ /index.php?url=nsk;\n    }\n\n    location ~ \.php$ {\n        include snippets/fastcgi-php.conf;\n        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;     }\n}' > time.test

server {
    listen 80;
    server_name time.test;

    root /var/www/html;
    index index.php index.html index.htm;

    location /nsk {
        try_files $uri $uri/ /index.php?city=nsk;
    }

    location /l-a {
        try_files $uri $uri/ /index.php?city=l-a;
    }


    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }
}

# sudo chmod -R 777 /var/www/html
sudo systemctl restart nginx