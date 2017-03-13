class ApplicationController < ActionController::Base
  before_filter :auth
  protect_from_forgery with: :exception

  def current_user
    if session[:github_user_id]
      User.where(:github_id => session[:github_user_id]).first
    end
  end

  private

  def auth
    unless session[:github_user_id]
      session[:return_to] = request.path
      redirect_to "/auth/github"
    end
  end
end
