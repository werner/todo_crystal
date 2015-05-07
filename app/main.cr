require "html/builder"
require "sqlite3"
require "pg"
require "json"
require "./helpers/*"
require "./models/*"
require "../../amatista/src/amatista"

task = Task.new("postgres://postgres@localhost/todo_crystal")

class TasksController < Amatista::Controller
  get "/" do
    tasks = task.all
    respond_to(:html, LayoutView.new(IndexView.new(tasks).to_s).to_s.strip)
  end

  get "/tasks.json" do
    tasks = task.all
    respond_to(:json, tasks.to_s.to_json)
  end

  get "/tasks/new" do
    respond_to(:html, LayoutView.new(NewView.new.to_s).to_s.strip)
  end

  post "/tasks/create" do |params|
    unless params.empty?
      task.create(params["description"][0])
    end
    redirect_to "/"
  end

  get "/tasks/edit/:id" do |params|
    id, description = unless params.empty?
                        record = task.find(params["id"][0])
                        [record.first[0], record.first[1]]
                      else
                        ["", ""]
                      end

    respond_to(:html, LayoutView.new(EditView.new(id, description).to_s).to_s.strip)
  end

  get "/tasks/:id/edit.json" do |params|
    unless params.empty?
      record = task.find(params["id"][0])
    else
      record = ["", ""]
    end

    respond_to(:json, record.to_s.to_json)
  end

  post "/tasks/update" do |params|
    unless params.empty?
      task.update(params["description"][0], params["id"][0])
    end
    redirect_to "/"
  end

  post "/tasks/:id/check" do |params|
    unless params.empty?
      task.check(params["done"][0], params["id"][0])
    end
    redirect_to "/"
  end

  post "/tasks/delete/:id" do |params|
    unless params.empty?
      task.delete(params["id"][0])
    end
    redirect_to "/"
  end
end

class Main < Amatista::Base

  configure do |conf|
    conf[:secret_key] = "secret"
  end
end

app = Main.new

PORT = 1234
p "Server running on #{PORT}"
app.run PORT
