class SessionsController < ApplicationController
  
  before_action :require_logged_in, only: [:destroy]
  
  def new
  end
  
  def create
    chef = Chef.find_by(email: get_params[:email])
    if chef && chef.authenticate(get_params[:password])
      flash[:notice] = "Welcome #{chef.name}!"
      session[:user_id] = chef.id
      redirect_to recipes_path
    else
      flash.now[:danger] = "Wrong email or password."
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Goodbye!"
    redirect_to root_path
  end
  
  private
  
  def get_params
    params.require(:session).permit(:email, :password)
  end
  
end