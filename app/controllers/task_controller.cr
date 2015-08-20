class TasksController < Amatista::Controller
  get "/" do
    tasks = Task.all
    respond_to(:html, IndexView.new(tasks).set_view)
  end

  get "/tasks.json" do
    tasks = Task.all
    respond_to(:json, tasks.to_s.to_json)
  end

  get "/tasks/new" do
    respond_to(:html, NewView.new.set_view)
  end

  post "/tasks/create" do |params|
    unless params.empty?
      Task.create(params["description"][0])
    end
    redirect_to "/"
  end

  get "/tasks/edit/:id" do |params|
    id, description = unless params.empty?
                        task = Task.find(params["id"][0])
                        [task.first[0], task.first[1]]
                      else
                        ["", ""]
                      end

    respond_to(:html, EditView.new(id, description).set_view)
  end

  get "/tasks/:id/edit.json" do |params|
    unless params.empty?
      task = Task.find(params["id"][0])
    else
      task = ["", ""]
    end

    respond_to(:json, task.to_s.to_json)
  end

  post "/tasks/update" do |params|
    unless params.empty?
      Task.update(params["description"][0], params["id"][0])
    end
    redirect_to "/"
  end

  post "/tasks/:id/check" do |params|
    unless params.empty?
      Task.check(params["done"][0], params["id"][0])
    end
    redirect_to "/"
  end

  post "/tasks/delete/:id" do |params|
    unless params.empty?
      Task.delete(params["id"][0])
    end
    redirect_to "/"
  end
end

