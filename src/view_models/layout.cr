class LayoutView < Amatista::BaseView
  def initialize(@include)
  end

  def logout
    form_tag("/sessions/destroy") do |form|
      form << content_tag(:div, 
                          submit_tag("Logout", { class: "btn btn-success" }),
                          { class: "col-xs-6" })
    end
  end

  def logged_in?
    !!get_session("user_id")
  end

  set_ecr "layout"
end
