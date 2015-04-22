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
        script({src: "/app/assets/javascript/jquery-2.1.3.min.js"}) {}
      end
      body do
        ul({style: "list-style-type: none;"}) do
          db.execute("select * from tasks") do |row|
            li do
              input({type: "checkbox", disabled: "disabled"}) {}
              text row[1].to_s
              a({href: "/tasks/edit/#{row[0]}"}) { text "Edit" }
              a({href: "/tasks/delete/#{row[0]}"}) { text "Delete" }
            end
          end
        end
        a({href: "/tasks/new"}) { text "New Task" }
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

app.get "/tasks/edit/:id" do |params|
  id, description = unless params.empty?
                      db = SQLite3::Database.new( db_filename )
                      task = db.execute("select * from tasks where id = ? limit 1", params["id"][0])
                      db.close

                      [task.first[0], task.first[1]]
                    else
                      ["", ""]
                    end

  "<html>
    <head>
      <title>Edit a Task</title>
    </head>
    <body>
      <h1> Edit a Task </h1>
      <form method='POST' action='/tasks/update'>
        <input type='hidden' name='id' value=#{id}>
        <input type='text' name='description' value='#{description}'>
        <input type='submit' value='Update'>
      </form>
    </body>
  </html>"
end

app.post "/tasks/update" do |params|
  p params
  unless params.empty?
    db = SQLite3::Database.new( db_filename ) 
    db.execute "update tasks set description = ? where id = ?", params["description"][0], params["id"][0]
    db.close
  end
  app.redirect_to "/"
end

PORT = 1234
p "Server running on #{PORT}"
app.run PORT
