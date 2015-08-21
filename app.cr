require "html/builder"
require "amatista"
require "sqlite3"
require "pg"
require "json"
require "./app/view_models/*"
require "./app/models/*"
require "./app/controllers/*"

class Main < Amatista::Base
  configure do |conf|
    conf[:secret_key]          = "secret"
    conf[:database_driver]     = "postgres"
    conf[:database_connection] = ENV["DATABASE_URL"] 
  end
end

app = Main.new

PORT = 1234
p "Server running on #{PORT}"
app.run PORT
