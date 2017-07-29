class ChefsController < ApplicationController
  
  before_action :get_chef, only: [:show, :edit, :update]
  
  def new
    @chef = Chef.new
  end
  
  def index
    @chefs = Chef.all
  end
  
  def edit
  end
  
  def update
    if @chef.update(get_params)
      redirect_to chef_path(@chef)
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def create
    @chef = Chef.new(get_params)
    if @chef.password === @chef.password_confirmation
      if @chef.save
        flash[:notice] = "Chef created correctly."
        redirect_to recipes_path
      else
        render 'new'
      end
    else
      @chef.errors[:base] << "Password and it's confirmation are not the same."
      render 'new'
    end
  end
  
  private
  
  def get_chef
    @chef = Chef.find(params[:id])
  end
  
  def get_params
    params.require(:chef).permit(:name, :email, :password, :password_confirmation)
  end
  
end