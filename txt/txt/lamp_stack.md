# LAMP STACK

> via linuxbabe's wordpress guide 

source: https://www.linuxbabe.com/ubuntu/install-lamp-stack-ubuntu-20-04-server-desktop

## APACHE

    sudo apt update
    sudo apt upgrade
    sudo apt install -y apache2 apache2-utils
    systemctl status apache2

    # ufw
    sudo ufw allow http
    
      # if not running:
      sudo systemctl start apache2
      sudo systemctl enable apache2
      apache2 -v

      # test url
      firefox http://hostname/
      
    # permissions
    sudo chown www-data:www-data /var/www/html/ -R
    
    # test
    sudo apache2ctl -t
    
      # if error: can't determine FQDN
      sudo vim /etc/apache2/conf-available/servername.conf
      
        ServerName localhost
      
      # enable config file
      sudo a2enconf servername.conf
           
      # reload config
      sudo systemctl reload apache2

## MARIADB

    sudo apt install -y mariadb-server mariadb-client
    systemctl status mariadb
    
      # if not running:
        sudo systemctl start mariadb
        sudo systemctl enable mariadb
    
    sudo mysql_secure_installation
      # ENTER
      # Y (ROOT PW): type in
      # ENTER
      # ENTER
      # ENTER
      # ENTER
          
    sudo mariadb -u root
    exit;
    
    mariadb --version
    
## PHP 7.4

    sudo apt install \
    php7.4 \
    libapache2-mod-php7.4 \
    php7.4-mysql \
    php-common \
    php7.4-cli \
    php7.4-common \
    php7.4-json \
    php7.4-opcache \
    php7.4-readline
    
    # enable php 7.4 module in apache
    sudo a2enmod php7.4
    sudo systemctl restart apache2
    
    # check php ver
    php --version
    
    # test/create info.php
    sudo vim /var/www/html/info.php
      <?php phpinfo(); ?>

## PHP-FPM WITH APACHE

    # disable the apache php7.4 module.
    sudo a2dismod php7.4
    # install php-fpm.
    sudo apt install php7.4-fpm
    # enable proxy_fcgi and setenvif module.
    sudo a2enmod proxy_fcgi setenvif
    # enable the /etc/apache2/conf-available/php7.4-fpm.conf configuration file.
    sudo a2enconf php7.4-fpm
    # restart apache for the changes to take effect.
    sudo systemctl restart apache2

## DEL INFO.PHP
    sudo rm /var/www/html/info.php
    
    
# OPTIONAL: PHPMYADMIN

### INSTALL PHPMYADMIN

    sudo apt update
    sudo apt install -y phpmyadmin
  
**instructions:**
  
- apache2 (highlight)
- enter
- yes (configure database for phpmyadmin w/ dbconfig-common)
- set password (phpmyadmin user in mariadb)

### CHECK PRIVILEGES

``` bash
    sudo mysql -u root
    show grants for phpmyadmin@localhost;
    exit; 
    
    # check if file exists
    file /etc/apache2/conf-enabled/phpmyadmin.conf
    
    # if not exist:
    sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
    sudo a2enconf phpmyadmin
    sudo systemctl reload apache2
```
    
### USEAGE

  Installation creates: `/etc/apache2/conf-enabled/phpmyadmin.conf`
  which allows us to access phpMyAdmin via sub-directory
  
    firefox http://host/phpmyadmin

### CHANGE TO SUBDOMAIN

``` bash
sudo cp /etc/apache2/conf-enabled/phpmyadmin.conf /etc/apache2/sites-available/phpmyadmin.conf
sudo vim /etc/apache2/sites-available/phpmyadmin.conf

    # this file lacks <virtualhost> tags
    # so we need to add the following lines at the beginning of this file

    <VirtualHost *:80>
        ServerName pma.example.com
        DocumentRoot /usr/share/phpmyadmin

        ErrorLog ${APACHE_LOG_DIR}/pma.error.log
        CustomLog ${APACHE_LOG_DIR}/pma.access.log combined
    </VirtualHost>

  
# enable this virtual host:
sudo a2ensite phpmyadmin.conf

# reload apache
sudo systemctl reload apache2

# access vai subdomain
firefox http://pma.host/
```
    



