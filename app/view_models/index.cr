require "ecr"
require "ecr/macros"

class IndexView
  def initialize(@tasks)
  end

  def tasks_count
    @tasks.count
  end

  ecr_file "app/views/index.ecr"
end
