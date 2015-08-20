class IndexView < Amatista::BaseView
  def initialize(@tasks)
  end

  def tasks_count
    @tasks.count
  end

  set_ecr "index"
end
