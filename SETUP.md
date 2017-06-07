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