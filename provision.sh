###############################################################
#e-media box
###############################################################
#This box is repackaged from amonteilhet/debian-stretch64 so contains vbox guest addition

###############################################################
#utilities
###############################################################
sudo apt-get update
sudo apt-get upgrade

###############################################################
#utilities
###############################################################
echo "installing utilities : $(date)"
sudo apt-get install -y git vim curl htop
curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

###############################################################
#php7.0
###############################################################
sudo apt-get install -y php7.0-fpm php7.0-gd php7.0-mysql php7.0-cli php7.0-common php7.0-curl php7.0-opcache php7.0-json php7.0-imap php7.0-mbstring php7.0-xml

###############################################################
#js
###############################################################
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install gulp jshint gulp-jshint bower grunt -g

###############################################################
#MariaDb
###############################################################
sudo apt-get install -y mariadb-server mariadb-common mariadb-client
sudo mysql -uroot -e "CREATE USER 'emedia'@'localhost' IDENTIFIED BY 'emedia';"
sudo mysql -uroot -e "GRANT ALL ON *.* TO 'emedia'@'localhost';"
###############################################################
#nginx
###############################################################
sudo apt-get install -y nginx
VHOST=$(cat <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    root /vagrant/sites/e-media/web;
    index app.php index.php index.htm;

    location / {
        #dev env
	#try_files \$uri /app_dev.php\$is_args\$args;
	#prod env
	try_files \$uri /app.php\$is_args\$args;

    }

    location ~ \.php\$ {
	include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.0-fpm.sock;   
    }
}
EOF
)
echo "${VHOST}" > /etc/nginx/sites-available/emedia
sudo rm -f /etc/nginx/sites-enabled/default 
sudo ln -s /etc/nginx/sites-available/emedia /etc/nginx/sites-enabled/emedia

sudo service nginx restart && sudo service php7.0-fpm restart

#webserver is runned by vagrant user, so change `www-data` to `vagrant`cusomisation in these files:
#/etc/php/7.0/fpm/pool.d/www.conf
#/etc/nginx/nginx.conf





