class SessionsController < Amatista::Controller
  get "/sessions/new" do
    respond_to(:html, SessionsNewView.new.set_view)
  end

  post "/sessions/create" do |params|
    unless params.empty?
      user = User.login(params["session[email]"][0], params["session[password]"][0])
      if user
        set_session("user_id", user[0][0].to_s)
        return redirect_to("/")
      end
    end
    redirect_to("/sessions/new")
  end
end
