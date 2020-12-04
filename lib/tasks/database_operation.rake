namespace :database_operation do
    desc "This task recreates the database and sets up the database with demo data"
    task :setup do
        sh "rails db:drop"
        sh "rails db:create"
        sh "rails db:migrate"
        sh "rails db:seed"
        puts "************************"
        puts "Database Setup Complete."
        puts "************************"
    end
end
