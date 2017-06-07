puts ""
puts "========================"
puts "== Seeding Start! =="
puts "========================"

global_password = "Admin"
amount_fake_adresses = 100
amount_fake_professions = 20
amount_fake_users = 199 # +1 Admin
amount_fake_departments = 5
amount_fake_operations = 20

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

#Create Admin
admin = User.create!(firstname: "Admin",
            lastname: "Admin",
            email: "admin@tricc.de",
            password:              global_password,
            password_confirmation: global_password,
            profession_id: profession_admin.id,
            admin: true)
            
admin.create_avatar_for_user

admin.create_avatar_for_user

#Create Other Users
amount_fake_users.times do |n|
      print "Seeding: Users ("+n.to_s+"/"+(amount_fake_users+1).to_s+ ")\r"
    
    
      names = [Faker::RockBand.name,Faker::RickAndMorty.character,Faker::StarWars.character,Faker::GameOfThrones.character,Faker::HarryPotter.character,Faker::HowIMetYourMother.character]
      choose = Random.new.rand(0..(names.length-1))
      
      complete_name = names[choose]
      
      splited_name = complete_name.split(" ")
      firstname = splited_name[0]
      lastname = splited_name[1]
      
      email = firstname.to_s+lastname.to_s+(n+1).to_s+"@tricc.de"
      
      if lastname==nil
         lastname=firstname   
      end
      
      user = User.create!(firstname: firstname,
            lastname: lastname,
            email: email,    #Email ist Key also noch +n damit unique
            password:              global_password,
            password_confirmation: global_password,
            profession_id: Profession.offset(rand(Profession.count)).first.id,      #Zufälliger Beruf
            admin: false,
            size: Faker::Demographic.height)

      user.create_avatar_for_user

end
print "Seeding: Users (Completed)\n"


#### DEPARTMENTS
amount_fake_departments.times do |n|
      print "Seeding: Departments ("+n.to_s+"/"+amount_fake_departments.to_s+ ")\r"
    
      address = Address.offset(rand(Address.count)).first      #Zufällige Adresse
      department_name  = address.city+" "+n.to_s+".Department"
      
      Department.create!(name: department_name,
                        address_id: address.id,
                        user_id: User.offset(rand(User.count)).first.id)
end
print "Seeding: Departments (Completed)\n"



#### ADDING DEPARMENTS TO USERS
amount_users = User.all.count
User.all.each do |user,n|
      print "Seeding: Assign User to Departments ("+n.to_s+"/"+amount_users.to_s+ ")\r"
      
      user.department_id = Department.offset(rand(Department.count)).first.id
      user.save!
end
print "Seeding: Assign User to Departments (Completed)\n"


#### OPERATIONS ####
amount_fake_operations.times do |n|
      print "Seeding: Operations ("+n.to_s+"/"+amount_fake_operations.to_s+ ")\r"
    
      chief = User.offset(rand(User.count)).first
      Operation.create!(user_id: chief.id,
                        activ: Faker::Boolean.boolean,
                        department_id: chief.department_id)
end
print "Seeding: Operations (Completed)\n"

puts ""
puts "========================"
puts "== Seeding Completed! =="
puts "========================"