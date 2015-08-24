class SessionsNewView < Amatista::BaseView
  def initialize
  end

  def form
    form_tag("/sessions/create") do |form|
      form << content_tag(:div, 
                          label_tag(:session_email, "Email:") +
                          text_field(:session, :email, { class: "form-control" }),
                          { class: "col-xs-6" })

      form << content_tag(:div, 
                          label_tag(:session_password, "Password:") +
                          password_field(:session, :password, { class: "form-control" }),
                          { class: "col-xs-6" })

      form << content_tag(:div, 
                          submit_tag("LogIn", { class: "btn btn-success" }),
                          { class: "col-xs-6" })
    end
  end

  set_ecr "sessions/new"
end
