drop_database = false
tables_dropping = ["addresses","departmens","professions","users","operations"]

namespace :db_tasks do
  desc "Rebuild database"
  task :rebuild, [] => :environment do
    raise "Not allowed to run on production" if Rails.env.production?
    
    if drop_database
      Rake::Task['db:drop'].execute
    end
    
    if !database_exists?
      Rake::Task['db:create'].execute
    end
    
    tables_dropping.each do |table|
      if ActiveRecord::Base.connection.table_exists? table.to_s
        Rake::Task['drop_table '+table.to_s].execute
      end
    end
    
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
  end
end

def database_exists?
  ActiveRecord::Base.connection
rescue ActiveRecord::NoDatabaseError
  false
else
  true
end