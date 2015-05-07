require "html/builder"
require "sqlite3"
require "pg"
require "json"
require "./helpers/*"
require "./controllers/*"
require "./models/*"
require "../../amatista/src/amatista"

task = Task.new("postgres://postgres@localhost/todo_crystal")

class Main < Amatista::Base
  configure do |conf|
    conf[:secret_key] = "secret"
  end
end

app = Main.new

PORT = 1234
p "Server running on #{PORT}"
app.run PORT
