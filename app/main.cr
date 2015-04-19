require "html/builder"
require "sqlite3"
require "../framework/server.cr"

app = Server::Base.new
db_filename = "db/data.sqlite3"

app.get "/" do
  db = SQLite3::Database.new( db_filename ) 
  str = HTML::Builder.new.build do
    html do
      head do
        title { text "Todo App" }
      end
      body do
        ul({style: "list-style-type: none;"}) do
          db.execute("select * from tasks") do |row|
            li do
              input({type: "checkbox", disabled: "disabled"}) {}
              text row[1].to_s
              a({href: "/tasks/edit/#{row[0]}"}) { text "Edit" }
            end
          end
        end
      end
    end
  end
  db.close
  str
end

app.get "/tasks/new" do
  %(<html>
    <head>
      <title>Add a new Task</title>
    </head>
    <body>
      <h1> Add a new Task </h1>
      <form method="POST" action="/tasks/create">
        <input type="text" name="description">
        <input type="submit" value="Create">
      </form>
    </body>
  </html>)
end

app.post "/tasks/create" do |params|
  unless params.empty?
    db = SQLite3::Database.new( db_filename ) 
    db.execute "insert into tasks(description, done) values ('#{params["description"][0]}', 0)"
    db.close
  end
  app.redirect_to "/"
end

PORT = 1234
p "Server running on #{PORT}"
app.run PORT
