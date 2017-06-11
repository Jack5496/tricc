class Profession < ActiveRecord::Base
    has_and_belongs_to_many :users  # Eine Profession kann von mehreren Usern besessen werden
end
