class TasksController < ApplicationController
  get "/" do
    tasks = Task.all_by_user(get_session("user_id"))
    respond_to(:html, TasksIndexView.new(tasks).set_view)
  end

  get "/tasks.json" do
    tasks = Task.all
    respond_to(:json, tasks.to_s.to_json)
  end

  get "/tasks/new" do
    respond_to(:html, TasksNewView.new.set_view)
  end

  post "/tasks/create" do |params|
    unless params.empty?
      Task.create(params["task"]["description"], get_session("user_id"))
    end
    redirect_to "/"
  end

  get "/tasks/edit/:id" do |params|
    id, description = unless params.empty?
                        task = Task.find(params["id"].first_key)
                        [task["id"], task["description"]]
                      else
                        ["", ""]
                      end

    respond_to(:html, TasksEditView.new(id, description).set_view)
  end

  get "/tasks/:id/edit.json" do |params|
    unless params.empty?
      task = Task.find(params["id"].first_key)
    else
      task = ["", ""]
    end

    respond_to(:json, task.to_s.to_json)
  end

  post "/tasks/update" do |params|
    unless params.empty?
      Task.update(params["task"]["description"], params["task"]["id"])
    end
    redirect_to "/"
  end

  post "/tasks/:id/check" do |params|
    unless params.empty?
      Task.check(params["done"].first_key, params["id"].first_key)
    end
    redirect_to "/"
  end

  post "/tasks/delete/:id" do |params|
    unless params.empty?
      Task.delete(params["id"].first_key)
    end
    redirect_to "/"
  end
end

