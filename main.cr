require "html/builder"
require "amatista"
require "sqlite3"
require "pg"
require "json"
require "./src/view_models/**"
require "./src/models/*"
require "./src/controllers/*"
require "option_parser"

class Main < Amatista::Base
  configure do |conf|
    conf[:secret_key]          = "secret"
    conf[:database_driver]     = "postgres"
    conf[:database_connection] = ENV["DATABASE_URL"] 
    conf[:logs]                = "true"
  end
end

