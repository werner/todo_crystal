require "html/builder"
require "sqlite3"
require "../web_server/server.cr"

app = Server::Base.new

app.get "/" do
  db_filename = "db/data.sqlite3"
  db = SQLite3::Database.new( db_filename ) 
  str = HTML::Builder.new.build do
    html do
      head do
        title { text "Todo App" }
      end
      body do
        ul do
          db.query("select * from items") do |row|
            li { row["description"] }
          end
        end
      end
    end
  end
  db.close
  str
end

PORT = 1234
p "Server running on #{PORT}"
app.run PORT
