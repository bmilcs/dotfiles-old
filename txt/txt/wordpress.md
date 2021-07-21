# WORDPRESS

> ubuntu 20.04.2 install

source: https://www.linuxbabe.com/ubuntu/install-wordpress-ubuntu-20-04-apache-mariadb-php7-4

## DOWNLOAD

    sudo apt update && sudo apt upgrade
    wget https://wordpress.org/latest.zip
    sudo apt install unzip
    sudo mkdir -p /var/www/
    sudo unzip latest.zip -d /var/www/
    sudo mv /var/www/wordpress /var/www/bmilcs.com
    
## CREATE DATABASE  

    sudo mariadb -u root # or: sudo mysql -u root
      create database bmwp;
      grant all privileges on bmwp.* to bmilcs@localhost identified by 'U2FsdGVkX1/1r3FWgddm5l9vqxULt84sHDxx2mY44BRijkBytte0AnyPfqvbeJbG';
      flush privileges;
      exit;

## CONFIGURE WORDPRESS

    cd /var/www/bmilcs.com/
    sudo cp wp-config-sample.php wp-config.php

    sudo vim wp-config.php

        /** The name of the database for WordPress */
        define('DB_NAME', 'database_name_here');

        /** MySQL database username */
        define('DB_USER', 'username_here');

        /** MySQL database password */
        define('DB_PASSWORD', 'password_here');

    sudo chown www-data:www-data /var/www/bmilcs.com/ -R
    
## APACHE ONLY >

    sudo vim /etc/apache2/sites-available/bmilcs.com.conf
    
        <VirtualHost *:80>       
            ServerName www.example.com
            ServerAlias example.com

            DocumentRoot /var/www/example.com

            #This enables .htaccess file, which is needed for WordPress Permalink to work. 
            <Directory "/var/www/example.com">
                 AllowOverride All
            </Directory>

            ErrorLog ${APACHE_LOG_DIR}/example.com.error.log
            CustomLog ${APACHE_LOG_DIR}/example.com.access.log combined
        </VirtualHost>

    sudo apache2ctl configtest
    
    # if “syntax ok”, then enable virtual host:
    sudo a2ensite bmilcs.com.conf
    sudo systemctl reload apache2
    
## NGINX ONLY >



## FIX NGINX PROXY IN



