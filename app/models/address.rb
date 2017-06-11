class Address < ActiveRecord::Base
    has_many :departments # Eine Adresse kann mehreren Departments angehören
    has_many :operations # Eine Adresse kann mehreren Operationen angehören
    
end
