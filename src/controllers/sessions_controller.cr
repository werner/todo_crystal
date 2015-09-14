class SessionsController < Amatista::Controller
  get "/sessions/new" do
    respond_to(:html, SessionsNewView.new.set_view)
  end

  post "/sessions/create" do |params|
    unless params.empty?
      email    = params["session"]["email"]
      password = params["session"]["password"]
      return redirect_to("/sessions/new") unless email.is_a?(String) && password.is_a?(String)

      user = User.login(email, password)
      if user
        set_session("user_id", user["id"])
        set_flash(:message, "User authenticated.")
        return redirect_to("/")
      else
        set_flash(:message, 
                  "Error in user authentication, please verify your email and password.")
      end
    end
    redirect_to("/sessions/new")
  end

  post "/sessions/destroy" do
    remove_session("user_id")
    redirect_to("/sessions/new")
  end
end
