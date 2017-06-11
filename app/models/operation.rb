class Operation < ActiveRecord::Base
    belongs_to :address
    belongs_to :chief, class_name: 'User'
    belongs_to :department
end
