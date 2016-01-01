require "html_builder"
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
    url_db = ENV["DATABASE_URL"]? || "postgres://postgres@localhost/todo_crystal"
    conf[:database_connection] = url_db
    conf[:logs]                = true
  end
end

