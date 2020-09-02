class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user

  def set_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  def authenticate_user
    if session[:user_id] == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end
  
  def forbid_login_user
    if session[:user_id]
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts/index")
    end
  end
end
