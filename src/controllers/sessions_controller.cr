class SessionsController < Amatista::Controller
  get "/sessions/new" do
    respond_to(:html, SessionsNewView.new.set_view)
  end

  post "/sessions/create" do |params|
    unless params.empty?
      user = User.login(params["session[email]"][0], params["session[password]"][0])
      if user
        set_session("user_id", user[0]["id"])
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
