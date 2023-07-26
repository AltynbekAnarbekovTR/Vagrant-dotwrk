# Update packages versions
sudo apt-get update

# Install required packages
sudo apt-get install nginx php8.1-fpm varnish -y

# Grant permissions
sudo chown -R $USER:$USER /etc/nginx/
sudo chown -R $USER:$USER /etc/varnish/

#Enable and start varnish and nginx
sudo systemctl enable varnish
sudo systemctl enable nginx
sudo systemctl start varnish
sudo systemctl start nginx

# Add virtual host time.test to nginx
sudo echo -e 'server {\n    listen 8080;\n    server_name time.test;\n\n    root /var/www/test.time;\n    index index.php index.html index.htm;\n\n    location /nsk {\n        try_files $uri $uri/ /index.php?city=nsk;\n    }\n\n    location /l-a {\n        try_files $uri $uri/ /index.php?city=l-a;\n    }\n\n    location / {\n        try_files $uri $uri/ /index.php?city=nsk;\n    }\n\n    location ~ \.php$ {\n        include snippets/fastcgi-php.conf;\n        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;     }\n}' > /etc/nginx/sites-available/time.test

# Enable created virtual host and delete default one
sudo ln -s /etc/nginx/sites-available/time.test /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default

# Configure varnish
sudo sed -i 's/DAEMON_OPTS="-a :6081/DAEMON_OPTS="-a :80/' /etc/default/varnish
sudo cp /lib/systemd/system/varnish.service /etc/systemd/system/
sudo sed -i 's/-a :6081/-a :80/' /etc/systemd/system/varnish.service
sudo rm /etc/varnish/default.vcl
sudo echo -e 'vcl 4.0;\n\nbackend default {\n    .host = "127.0.0.1";\n    .port = "8080";\n}\n\nsub vcl_recv {\n    if (req.url ~ "^test.time/nsk") {\n        return (hash);\n    } elseif (req.url ~ "^test.time") {\n        return (hash);\n    } elseif (req.url ~ "^test.time/l-a") {\n        return (pass);\n    }\n}\n\nsub vcl_backend_response {\n    if (bereq.url ~ "^test.time/nsk" || bereq.url ~ "^test.time") {\n        set beresp.ttl = 30s;\n    }\n}' > /etc/varnish/default.vcl

# Restart everything to apply changes
sudo systemctl daemon-reload
sudo systemctl restart varnish
sudo systemctl restart nginx