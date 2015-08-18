require "ecr"
require "ecr/macros"

class LayoutView
  def initialize(@include)
  end

  ecr_file "app/views/layout.ecr"
end
