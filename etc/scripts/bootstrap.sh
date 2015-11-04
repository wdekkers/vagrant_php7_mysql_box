# Install SQL Client
yum install -y httpd mysql-server mysql-client
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

# Install PHP 7
yum install -y --enablerepo=webtatic-testing php70w php70w-opcache

# Change php conf to start php7 instead php5
sed -i 's/php5/php7/g' /etc/httpd/conf.d/php.conf

# Setup virtual hosts
echo "
  <VirtualHost *:80>
      DocumentRoot "/vagrant/websites/yoursite.local"
      <Directory "/vagrant/websites/yoursite.local">
          Allow From All
          AllowOverride All
      </Directory>
      ErrorLog /vagrant/var/logs/yoursite
  </VirtualHost>
" > /etc/httpd/conf.d/my-websites.conf

# Bind address to make MySQL available
grep -q -F 'bind-address = 127.0.0.1' /etc/my.cnf || printf '\n\nbind-address = 127.0.0.1\n' >> /etc/my.cnf

# Enable services
chkconfig mysqld on
chkconfig httpd on

# Start / Stop services
service mysqld start
service httpd start
service iptables stop

# Create database with user root and no password
mysql -u root -e "create database database_name; 
create user 'root'@'%' identified by '';
grant all privileges on *.* to 'root'@'%' with grant option;
flush privileges;
"