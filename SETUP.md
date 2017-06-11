sudo apt-get update
sudo apt-get install imagemagick libmagickcore-dev libmagickwand-dev
bundle install

rails generate bootstrap:install less
rails generate bootstrap:install static

rails generate scaffold Address
rails generate scaffold Department
rails generate scaffold Profession
rails generate scaffold User
rails generate scaffold Operation

rails generate controller StaticPages home help
rails generate controller Sessions new

rails generate uploader Picture

https://stackoverflow.com/questions/21605318/how-can-i-serve-requests-concurrently-with-rails-4/23607885
config.cache_classes=false  # Default
config.allow_concurrency=true #Changed

Es wurde für die realisierung von SSE ein Puma Server verwendet



MySQL - Für Remote Access
in mysql
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'tricc' WITH GRANT OPTION;
FLUSH PRIVILEGES;

in /etc/mysql/my.cnf
#bind-address = 127.0.0.1 