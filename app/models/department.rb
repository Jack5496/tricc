class Department < ActiveRecord::Base
    belongs_to :address
    has_many :users # Einem Department können mehrere User angehören
    belongs_to :chief, class_name: 'User'
    #belongs_to :chief, :foreign_key => 'user_id'
    has_many :operations # Eine Adresse kann mehreren Operationen angehören
end
