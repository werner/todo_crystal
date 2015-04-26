require "ecr"
require "ecr/macros"

class IndexView
  def initialize(@tasks)
  end

  ecr_file "app/views/index.ecr"
end
