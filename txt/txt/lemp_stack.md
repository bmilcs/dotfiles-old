# LEMP STACK

> from nextcloud install guide

> https://www.linuxbabe.com/ubuntu/install-lemp-stack-ubuntu-20-04-server-desktop

## INSTALL: NGINX / UFW
    sudo apt update
    sudo apt upgrade
    sudo apt install -y nginx ufw
    sudo systemctl enable ufw
    sudo systemctl start ufw
    sudo ufw allow ssh
    sudo ufw allow 'Nginx Full'
    sudo ufw enable
    sudo chown www-data:www-data /usr/share/nginx/html -R

## INSTALL: MARIADB
    sudo apt -y install mariadb-server mariadb-client
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
    sudo mysql_secure_installation
    
      # ENTER
      # Y (ROOT PW)
      # ENTER
      # ENTER
      # ENTER
      # ENTER

## PHP7.3
> https://www.vultr.com/docs/how-to-install-nextcloud-on-debian-10

    # debian
    sudo apt -y install \
    libmagickcore-6.q16-6-extra
    php-bcmath \
    php-bz2 \
    php-cli \
    php-common \
    php-curl \
    php-dev \
    php-fpm \
    php-gd \
    php-gmp \
    php-imagick \
    php-intl \
    php-json \
    php-mbstring \
    php-mysql \
    php-pear \
    php-soap \
    php-xml \
    php-zip \

## CONFIG: NGINX

    sudo rm /etc/nginx/sites-enabled/default
    
    sudo vim /etc/nginx/conf.d/default.conmf
    ----------------------------------------------------
      server {
        listen 80;
        listen [::]:80;
        server_name _;
        root /usr/share/nginx/html/;
        index index.php index.html index.htm index.nginx-debian.html;

        location / {
          try_files $uri $uri/ /index.php;
        }

        location ~ \.php$ {
          fastcgi_pass unix:/run/php/php7.3-fpm.sock;
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
          include fastcgi_params;
          include snippets/fastcgi-php.conf;
        }

       # A long browser cache lifetime can speed up repeat visits to your page
        location ~* \.(jpg|jpeg|gif|png|webp|svg|woff|woff2|ttf|css|js|ico|xml)$ {
             access_log        off;
             log_not_found     off;
             expires           360d;
        }

        # disable access to hidden files
        location ~ /\.ht {
            access_log off;
            log_not_found off;
            deny all;
        }
      }

## TEST PHP
    sudo vim /usr/share/nginx/html/info.php
    ----------------------------------------------------
      <?php phpinfo(); ?>

## SYSTEMD: AUTO-RESTART

    sudo mkdir -p /etc/systemd/system/nginx.service.d/
    
    sudo nvim /etc/systemd/system/nginx.service.d/restart.conf
    ------------------------------------------------------------
      [Service]
      Restart=always
      RestartSec=5s
      
    sudo systemctl daemon-reload
    sudo pkill nginx
