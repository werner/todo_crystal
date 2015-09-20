class TasksIndexView < Amatista::BaseView
  def initialize(@tasks)
  end

  def tasks_count
    @tasks.size
  end

  set_ecr "tasks/index"
end
