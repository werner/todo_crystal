class SessionsController < Amatista::Controller
  get "/sessions/new" do
    respond_to(:html, SessionsNewView.new.set_view)
  end
end
