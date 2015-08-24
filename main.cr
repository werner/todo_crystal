require "html/builder"
require "../amatista/src/amatista"
require "sqlite3"
require "pg"
require "json"
require "./src/view_models/*"
require "./src/models/*"
require "./src/controllers/*"
require "option_parser"

class Main < Amatista::Base
  configure do |conf|
    conf[:secret_key]          = "secret"
    conf[:database_driver]     = "postgres"
    conf[:database_connection] = ENV["DATABASE_URL"] 
  end
end

app = Main.new

main_port = 1234
OptionParser.parse! do |opts|
  opts.on("-p PORT", "--port PORT", "define port to run server") do |port|
    main_port = port.to_i
  end
end
p "Server running on #{main_port}"
app.run main_port
