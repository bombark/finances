class SessionsController < ApplicationController
  def new
  end


  def create
    begin
        user = Vertice::User.find_by_email(params[:session][:email])
        session[:user_id] = user.id;
        redirect_to "/home";
    rescue
        redirect_to "/login", alert:"Usuario ou Senha invalida"
    end
  end

  def destroy
    reset_session
    redirect_to :root
  end

end
