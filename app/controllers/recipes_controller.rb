class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:show]
  
  def index
    @recipes = Recipe.all
  end 
  
  def show
    @recipe = set_recipe
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(get_params)
    @recipe.chef = Chef.first
    if @recipe.save
      flash[:notice] = "Recipe created correctly"
      redirect_to recipe_path(@recipe)
    else
      render 'new' 
    end
  end
  
  private
  
  def set_recipe
    Recipe.find(params[:id])
  end
  
  def get_params
    params.require(:recipe).permit(:name, :description)
  end
  
end