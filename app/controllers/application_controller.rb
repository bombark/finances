class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_user


  @current_user = nil

  private
  def current_user
    if @current_user.nil? && session[:user_id].present?
        @current_user = Vertice::Vertice.find(session[:user_id])
        @current_user.set_online
    end
    return @current_user
  end


end
