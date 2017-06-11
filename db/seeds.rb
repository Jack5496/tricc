puts ""
puts "========================"
puts "== Seeding Start! =="
puts "========================"

ActiveRecord::Base.logger.level = 1 # Disable SQL Information

global_password = "Admin"
amount_fake_adresses = 10
amount_fake_professions = 10
max_amount_fake_professions_per_user = 7

amount_fake_users = 9 # +1 Admin
amount_fake_departments = 5
amount_fake_operations = 5

#### ADDRESSES ####
amount_fake_adresses.times do |n|
      print "Seeding: Addresses ("+n.to_s+"/"+amount_fake_adresses.to_s+ ")\r"
      Address.create!(city: Faker::Address.city,
                        postcode: Faker::Address.postcode,
                        street: Faker::Address.street_name,
                        building_number: n)
end
print "Seeding: Addresses (Completed)\n"


#### PROFESSIONS ####
profession_admin = Profession.create!(name: "Administrator")
amount_fake_professions.times do |n|
      print "Seeding: Professions ("+n.to_s+"/"+amount_fake_professions.to_s+ ")\r"
    
      profession_name = Faker::Job.title+n.to_s     # +n Damit die Beufsklasse einzigartig ist
      Profession.create!(name: profession_name)
end
print "Seeding: Professions (Completed)\n"


#### USERS ####

admin_to_create = true

#Create Other Users
amount_fake_users.times do |n|
      print "Seeding: Users ("+n.to_s+"/"+(amount_fake_users+1).to_s+ ")\r"
    
    
      names = [Faker::RockBand.name,Faker::RickAndMorty.character,Faker::StarWars.character,Faker::GameOfThrones.character,Faker::HarryPotter.character]
      choose = Random.new.rand(0..(names.length-1))
      
      complete_name = names[choose]
      
      splited_name = complete_name.split(" ")
      firstname = splited_name[0]
      lastname = splited_name[1]
      
      email = firstname.to_s+lastname.to_s+(n+1).to_s+"@tricc.de"
      
      if lastname==nil
         lastname=firstname   
      end
      
      professions = []
      
      amount_fake_professions_per_user = rand(1..max_amount_fake_professions_per_user)
      
      amount_fake_professions_per_user.times do 
            professions.push(Profession.offset(rand(Profession.count)).first)
      end
      
      phone_number = Faker::PhoneNumber.cell_phone
      information = Faker::RickAndMorty.quote
      information = information[0..-254]   # Da String max. 255 lang sein darf
      
      if admin_to_create
            firstname = "Admin"
            lastname = "Admin"
            email = "admin@tricc.de"
            professions = [profession_admin]
      end
      
      user = User.create!(firstname: firstname,
            lastname: lastname,
            email: email,    #Email ist Key also noch +n damit unique
            password:              global_password,
            password_confirmation: global_password,
            professions: professions,      #Zufälliger Beruf
            admin: admin_to_create,
            phone_number: phone_number,
            view_device_type: "Console",
            information: information,
            size: Faker::Demographic.height)

      user.create_avatar_for_user
      
      admin_to_create = false

end
print "Seeding: Users (Completed)\n"


#### DEPARTMENTS
amount_fake_departments.times do |n|
      print "Seeding: Departments ("+n.to_s+"/"+amount_fake_departments.to_s+ ")\r"
    
      address = Address.offset(rand(Address.count)).first      #Zufällige Adresse
      department_name  = address.city+" "+n.to_s+".Department"
      
      Department.create!(name: department_name,
                        address: address,
                        chief: User.offset(rand(User.count)).first)

end
print "Seeding: Departments (Completed)\n"



#### ADDING DEPARMENTS TO USERS
amount_users = User.all.count
User.all.each do |user,n|
      print "Seeding: Assign User to Departments ("+n.to_s+"/"+amount_users.to_s+ ")\r"
      
      user.department = Department.offset(rand(Department.count)).first
      user.save!
end
print "Seeding: Assign User to Departments (Completed)\n"


#### OPERATIONS ####
amount_fake_operations.times do |n|
      print "Seeding: Operations ("+n.to_s+"/"+amount_fake_operations.to_s+ ")\r"
    
      types = ["Fire","Rescue","Emergency","Accident"]
      type = types[Random.new.rand(0..(types.length-1))]
    
      address = Address.offset(rand(Address.count)).first      #Zufällige Adresse
      
      chief = User.offset(rand(User.count)).first
      Operation.create!(chief: chief,
                        operation_type: type,
                        address: address,
                        activ: Faker::Boolean.boolean,
                        department: chief.department)
end
print "Seeding: Operations (Completed)\n"

ActiveRecord::Base.logger.level = 0 # Enable SQL Information

puts ""
puts "========================"
puts "== Seeding Completed! =="
puts "========================"