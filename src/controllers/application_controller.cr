class ApplicationController < Amatista::Controller
  before_filter(condition: !get_session("user_id")) do
    redirect_to("/sessions/new")
  end
end
