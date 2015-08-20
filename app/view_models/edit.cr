class EditView < Amatista::BaseView
  def initialize(@id, @description)
  end

  # Somehow I can't use this directly in the ecr template
  # I guess blocks like this are not allowed (yet?)
  def form
    form_tag("/tasks/update") do |form|
      form << content_tag(:div, 
                          text_field(:task, :description, { class: "form-control" }),
                          { class: "col-xs-6" })
      form << content_tag(:div, 
                          submit_tag("Create", { class: "btn btn-success" }),
                          { class: "col-xs-6" })
    end
  end

  set_ecr "edit"
end
