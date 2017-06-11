puts ""
puts "========================"
puts "=  Rebulding Database! ="
puts "========================"
#ActiveRecord::Base.logger.level = 1 # Damit keine hässlichen SQL Ausageb kommen

drop_database = true
tables_dropping = ["addresses","departmens","professions","users","operations"]

namespace :db_tasks do
  desc "Rebuild database"
  task :rebuild, [] => :environment do
    raise "Not allowed to run on production" if Rails.env.production?
    
    if drop_database
      print "Database: Drop (Pending)\r"
      Rake::Task['db:drop'].execute
      print "Database: Drop (Completed)\n"
    end
    
    if !database_exists?
      print "Database: Create (Pending)\r"
      Rake::Task['db:create'].execute
      print "Database: Create (Completed)\n"
    end
    
    print "Database: Migrate (Pending)\r"
    Rake::Task['db:migrate'].execute
    print "Database: Migrate (Completed)\n"
    
    print "Database: Seeding (Pending)\r"
    Rake::Task['db:seed'].execute
    print "Database: Seeding (Completed)\n"
    
    
    puts ""
    puts "========================"
    puts "= Rebulding Completed! ="
    puts "========================"
    ActiveRecord::Base.logger.level = 0 # Die SQL Ausgaben dürfen wieder angezeigt werden
  end
end

def database_exists?
  ActiveRecord::Base.connection
rescue ActiveRecord::NoDatabaseError
  false
else
  true
end


