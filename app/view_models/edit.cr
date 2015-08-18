require "ecr"
require "ecr/macros"

class EditView
  def initialize(@id, @description)
  end

  ecr_file "app/views/edit.ecr"
end
