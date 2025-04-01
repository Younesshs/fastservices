server {
    server_name www.fastservices.pro fastservices.pro;

    root /var/www/html/fastservices.pro;
    index index.php;

    # Log files
    access_log /var/log/nginx/fastservices.pro.access.log;
    error_log /var/log/nginx/fastservices.pro.error.log;

	# Favicon
    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

	# Robots
    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

	# Wordpress
    location / {
        try_files $uri $uri/ /index.php?$args;
    }

	# Php
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
    }

    #PhpMyAdmin
    
    
	# Assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires max;
        log_not_found off;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/fastservices.pro/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/fastservices.pro/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    if ($host = www.fastservices.pro) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = fastservices.pro) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name www.fastservices.pro fastservices.pro;
    return 404; # managed by Certbot
}
