class EditView < Amatista::BaseView
  def initialize(@id, @description)
  end

  set_ecr "edit"
end
