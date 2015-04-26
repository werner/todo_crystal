require "html/builder"
require "sqlite3"
require "json"
require "./helpers/*"
require "amatista"

app = Amatista::Base.new
db_filename = "db/data.sqlite3"

app.get "/" do
  db = SQLite3::Database.new( db_filename ) 
  tasks = db.execute("select * from tasks")
  db.close
  app.respond_to(:html, LayoutView.new(IndexView.new(tasks).to_s).to_s.strip)
end

app.get "/tasks.json" do
  db = SQLite3::Database.new( db_filename ) 
  tasks = db.execute("select * from tasks")
  app.respond_to(:json, tasks.to_s.to_json)
end

app.get "/tasks/new" do
  app.respond_to(:html, LayoutView.new(NewView.new.to_s).to_s.strip)
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

  app.respond_to(:html, LayoutView.new(EditView.new(id, description).to_s).to_s.strip)
end

app.get "/tasks/:id/edit.json" do |params|
  unless params.empty?
    db = SQLite3::Database.new( db_filename )
    task = db.execute("select * from tasks where id = ? limit 1", params["id"][0])
    db.close
  else
    task = ["", ""]
  end

  app.respond_to(:json, task.to_s.to_json)
end

app.post "/tasks/update" do |params|
  unless params.empty?
    db = SQLite3::Database.new( db_filename ) 
    db.execute "update tasks set description = ? where id = ?", params["description"][0], params["id"][0]
    db.close
  end
  app.redirect_to "/"
end

app.post "/tasks/:id/check" do |params|
  unless params.empty?
    db = SQLite3::Database.new( db_filename ) 
    db.execute "update tasks set done = ? where id = ?", params["done"][0], params["id"][0]
    db.close
  end
  app.redirect_to "/"
end

app.post "/tasks/delete/:id" do |params|
  unless params.empty?
    db = SQLite3::Database.new( db_filename ) 
    db.execute "delete from tasks where id = ?", params["id"][0]
    db.close
  end
  app.redirect_to "/"
end

PORT = 1234
p "Server running on #{PORT}"
app.run PORT
