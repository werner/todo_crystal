require "html/builder"
require "sqlite3"
require "json"
require "./helpers/*"
require "amatista"

db_filename = "db/data.sqlite3"

class TasksController < Amatista::Controller
  get "/" do
    db = SQLite3::Database.new( db_filename ) 
    tasks = db.execute("select * from tasks")
    db.close
    respond_to(:html, LayoutView.new(IndexView.new(tasks).to_s).to_s.strip)
  end

  get "/tasks.json" do
    db = SQLite3::Database.new( db_filename ) 
    tasks = db.execute("select * from tasks")
    respond_to(:json, tasks.to_s.to_json)
  end

  get "/tasks/new" do
    respond_to(:html, LayoutView.new(NewView.new.to_s).to_s.strip)
  end

  post "/tasks/create" do |params|
    unless params.empty?
      db = SQLite3::Database.new( db_filename ) 
      db.execute "insert into tasks(description, done) values ('#{params["description"][0]}', 0)"
      db.close
    end
    redirect_to "/"
  end

  get "/tasks/edit/:id" do |params|
    id, description = unless params.empty?
                        db = SQLite3::Database.new( db_filename )
                        task = db.execute("select * from tasks where id = ? limit 1", params["id"][0])
                        db.close

                        [task.first[0], task.first[1]]
                      else
                        ["", ""]
                      end

    respond_to(:html, LayoutView.new(EditView.new(id, description).to_s).to_s.strip)
  end

  get "/tasks/:id/edit.json" do |params|
    unless params.empty?
      db = SQLite3::Database.new( db_filename )
      task = db.execute("select * from tasks where id = ? limit 1", params["id"][0])
      db.close
    else
      task = ["", ""]
    end

    respond_to(:json, task.to_s.to_json)
  end

  post "/tasks/update" do |params|
    unless params.empty?
      db = SQLite3::Database.new( db_filename ) 
      db.execute "update tasks set description = ? where id = ?", params["description"][0], params["id"][0]
      db.close
    end
    redirect_to "/"
  end

  post "/tasks/:id/check" do |params|
    unless params.empty?
      db = SQLite3::Database.new( db_filename ) 
      db.execute "update tasks set done = ? where id = ?", params["done"][0], params["id"][0]
      db.close
    end
    redirect_to "/"
  end

  post "/tasks/delete/:id" do |params|
    unless params.empty?
      db = SQLite3::Database.new( db_filename ) 
      db.execute "delete from tasks where id = ?", params["id"][0]
      db.close
    end
    redirect_to "/"
  end
end

class Main < Amatista::Base
end

app = Main.new

PORT = 1234
p "Server running on #{PORT}"
app.run PORT
