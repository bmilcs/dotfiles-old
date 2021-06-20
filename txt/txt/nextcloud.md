#─────────────  nextcloud manual install (debian 10, nextcloud-21.0.2)  ───────
# date: 06/18/2021
# vm: cloud.bm.bmilcs.com

#───────────────────────────────────────────────────────────────  NOTE  ───────

# *******IMPORTANT REMINDERS
# 1) DEBIAN's PHP packages differ from UBUNTU instructions

#    time of install:
#    - Ubuntu = 7.4
#    - Debian = 7.3

#    *** Required modifying several references to php7.4, *-fpm, etc.

################################################################################
################################## LEMP STACK ##################################
################################################################################

# https://www.linuxbabe.com/ubuntu/install-lemp-stack-ubuntu-20-04-server-desktop

# NGINX / UFW
sudo apt update
sudo apt upgrade
sudo apt install -y nginx ufw
sudo systemctl enable ufw
sudo systemctl start ufw
sudo ufw allow ssh
sudo ufw allow 'Nginx Full'
sudo ufw enable
sudo chown www-data:www-data /usr/share/nginx/html -R

# MARIADB
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

# PHP7.3
  # https://www.vultr.com/docs/how-to-install-nextcloud-on-debian-10

  # debian
  sudo apt -y install php-fpm php-curl php-cli php-mysql php-gd php-common php-xml php-json php-intl php-pear php-imagick php-dev php-common php-mbstring php-zip php-soap php-bz2 php-bcmath php-gmp php-imagick libmagickcore-6.q16-6-extra

# NGINX

sudo rm /etc/nginx/sites-enabled/default
sudo vim /etc/nginx/conf.d/default.conmf

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

# TEST PHP
sudo vim /usr/share/nginx/html/info.php
  <?php phpinfo(); ?>

# NGINX AUTO RESTART
sudo mkdir -p /etc/systemd/system/nginx.service.d/
sudo nvim /etc/systemd/system/nginx.service.d/restart.conf
  [Service]
  Restart=always
  RestartSec=5s
sudo systemctl daemon-reload
sudo pkill nginx

################################################################################
################################## NEXTCLOUD ###################################
################################################################################

# https://www.linuxbabe.com/ubuntu/install-nextcloud-ubuntu-20-04-nginx-lemp-stack

wget https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip
sudo apt install unzip
sudo unzip nextcloud-21.0.2.zip -d /usr/share/nginx/
sudo chown www-data:www-data /usr/share/nginx/nextcloud/ -R

# DATABASE MARIADB 
sudo mysql
create database nextcloud;
create user bmilcs@localhost identified by 'your-password';
grant all privileges on nextcloud.* to bmilcs@localhost identified by 'your-password';
flush privileges;
exit;

# CREATE NGINX CONFIG FOR NEXTCLOUD
sudo nvim /etc/nginx/conf.d/nextcloud.conf
  server {
      listen 80;
      listen [::]:80;
      server_name cloud.*;

      # Add headers to serve security related headers
      add_header X-Content-Type-Options nosniff;
      add_header X-XSS-Protection "1; mode=block";
      add_header X-Robots-Tag none;
      add_header X-Download-Options noopen;
      add_header X-Permitted-Cross-Domain-Policies none;
      add_header Referrer-Policy no-referrer;

      #I found this header is needed on Ubuntu, but not on Arch Linux. 
      add_header X-Frame-Options "SAMEORIGIN";

      # Path to the root of your installation
      root /usr/share/nginx/nextcloud/;

      access_log /var/log/nginx/nextcloud.access;
      error_log /var/log/nginx/nextcloud.error;

      location = /robots.txt {
          allow all;
          log_not_found off;
          access_log off;
      }

      # The following 2 rules are only needed for the user_webfinger app.
      # Uncomment it if you're planning to use this app.
      #rewrite ^/.well-known/host-meta /public.php?service=host-meta last;
      #rewrite ^/.well-known/host-meta.json /public.php?service=host-meta-json
      # last;

      location = /.well-known/carddav {
          return 301 $scheme://$host/remote.php/dav;
      }
      location = /.well-known/caldav {
         return 301 $scheme://$host/remote.php/dav;
      }

      location ~ /.well-known/acme-challenge {
        allow all;
      }

      # set max upload size
      client_max_body_size 512M;
      fastcgi_buffers 64 4K;

      # Disable gzip to avoid the removal of the ETag header
      gzip off;

      # Uncomment if your server is build with the ngx_pagespeed module
      # This module is currently not supported.
      #pagespeed off;

      error_page 403 /core/templates/403.php;
      error_page 404 /core/templates/404.php;

      location / {
         rewrite ^ /index.php;
      }

      location ~ ^/(?:build|tests|config|lib|3rdparty|templates|data)/ {
         deny all;
      }
      location ~ ^/(?:\.|autotest|occ|issue|indie|db_|console) {
         deny all;
       }

      location ~ ^/(?:index|remote|public|cron|core/ajax/update|status|ocs/v[12]|updater/.+|ocs-provider/.+|core/templates/40[34])\.php(?:$|/) {
         include fastcgi_params;
         fastcgi_split_path_info ^(.+\.php)(/.*)$;
         try_files $fastcgi_script_name =404;
         fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
         fastcgi_param PATH_INFO $fastcgi_path_info;
         #Avoid sending the security headers twice
         fastcgi_param modHeadersAvailable true;
         fastcgi_param front_controller_active true;
         fastcgi_pass unix:/run/php/php7.3-fpm.sock;
         fastcgi_intercept_errors on;
         fastcgi_request_buffering off;
      }

      location ~ ^/(?:updater|ocs-provider)(?:$|/) {
         try_files $uri/ =404;
         index index.php;
      }

      # Adding the cache control header for js and css files
      # Make sure it is BELOW the PHP block
      location ~* \.(?:css|js)$ {
          try_files $uri /index.php$uri$is_args$args;
          add_header Cache-Control "public, max-age=7200";
          # Add headers to serve security related headers (It is intended to
          # have those duplicated to the ones above)
          add_header X-Content-Type-Options nosniff;
          add_header X-XSS-Protection "1; mode=block";
          add_header X-Robots-Tag none;
          add_header X-Download-Options noopen;
          add_header X-Permitted-Cross-Domain-Policies none;
          add_header Referrer-Policy no-referrer;
          # Optional: Don't log access to assets
          access_log off;
     }

     location ~* \.(?:svg|gif|png|html|ttf|woff|ico|jpg|jpeg)$ {
          try_files $uri /index.php$uri$is_args$args;
          # Optional: Don't log access to other assets
          access_log off;
     }
  }

# NEXTCLOUD USER DATA
sudo mkdir /usr/share/nginx/nextcloud-data
sudo chown www-data:www-data /usr/share/nginx/nextcloud-data -R

# FINISH WEB-BASED INSTALLATION

  - DATA FOLDER: /usr/share/nginx/nextcloud-data
  - LOGIN FIRST TIME

#───────────────────────────────────────────────────────────────  HELP  ───────

# reset nextcloud user password
sudo -u www-data php /usr/share/nginx/nextcloud/occ user:resetpassword nextcloud_username

# list available commands:
sudo -u www-data php /usr/share/nginx/nextcloud/occ
# or
sudo -u www-data php /usr/share/nginx/nextcloud/console.php

# email notifications 
  # install smtp web server [iredmail]
  # https://www.linuxbabe.com/mail-server/ubuntu-20-04-iredmail-server-installation

  # > settings > personal info
  # enter e-mail address

################################################################################
############################### NEXTCLOUD FIXES ################################
################################################################################

#────────────────────────────────────────────────────  IMPORTANT PATHS  ───────

  # nextcloud: config.php:
  sudo nvim /usr/share/nginx/nextcloud/config/config.php

  # nextcloud: nginx config
  sudo nvim /etc/nginx/conf.d/nextcloud.conf

  # php config
  # sudo nvim /etc/php/$VERSION/fpm/php.ini
  sudo nvim /etc/php/7.3/fpm/php.ini

#───────────────────────────────────────────────────  SUBDOMAIN VALUES  ───────

  # nginx
  cloud.*

  # nextcloud config.php
  cloud.*

#─────────────────────────────────────────────  UPLOAD FILE SIZE LIMIT  ───────

# PHP SETTINGS
  
  sudo sed -i 's/memory_limit = 128M/memory_limit = 2G/g' /etc/php/7.4/fpm/php.ini

  # or

  sudo nvim /etc/php/7.3/fpm/php.ini

    memory_limit = 2G
    upload_max_filesize = 2G

# NGINX SETTINGS

  sudo nvim /etc/nginx/conf.d/nextcloud.conf
    client_max_body_size 2G;

  sudo systemctl reload nginx

#──────────────────────────────────  PHP QUERY ENVIRONMENTAL VARIABLES  ───────

sudo sed -i 's/;clear_env = no/clear_env = no/g' /etc/php/7.3/fpm/pool.d/www.conf

# or

sudo nvim /etc/php/7.4/fpm/pool.d/www.conf
  # uncomment
  ;clear_env = no

#────────────────────────────────────────────────────  NO MEMORY CACHE  ───────

sudo apt -y install redis-server
sudo apt -y install php-redis

# enable both services

sudo nvim /usr/share/nginx/nextcloud/config/config.php

  # after this line:
  # 'installed' => true
  'memcache.distributed' => '\OC\Memcache\Redis',
  'memcache.local' => '\OC\Memcache\Redis',
  'memcache.locking' => '\OC\Memcache\Redis',
  'redis' => array(
       'host' => 'localhost',
       'port' => 6379,
       ),
  #);

sudo systemctl restart nginx php7.3-fpm.service

#────────────────────────────────────────────────  ADD MISSING INDEXES  ───────

cd /usr/share/nginx/nextcloud/
sudo -u www-data php occ db:add-missing-indices

#────────────────────────────────────────────────────  LOCAL DNS ENTRY  ───────

sudoedit /etc/hosts

  127.0.0.1   localhost focal ubuntu nextcloud.example.com collabora.example.com

#────────────────────────────────────────────────────  TOO MANY LOGINS  ───────

sudo mariadb
  DELETE FROM oc_bruteforce_attempts;

################################################################################
############################# LETSENCRYPT CERTBOT ##############################
################################################################################

sudo apt install python-certbot-nginx python-certbot-dns-cloudflare

# ~/bin/lab/certs

  sudo certbot \
    certonly \
    --agree-tos \
    --hsts \
    --staple-ocsp \
    --dns-cloudflare \
    --dns-cloudflare-credentials /etc/letsencrypt/cloudflare.ini \
    -d "$1.bmilcs.com"
  # --redirect \
  # --nginx \

  sudo certbot \
    --reinstall \
    --hsts \
    --agree-tos \
    --staple-ocsp \
    -d "$1.bmilcs.com" \
    -i nginx

