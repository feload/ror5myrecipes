class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  
  def index
    @recipes = Recipe.all
  end 
  
  def show
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
  
  def edit
  end
  
  def update
    if @recipe.update(get_params)
      # Rails.logger.info 'GOT UPDATED'
      flash[:notice] = "Recipe updated correctly"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end
  
  def destroy
    if @recipe.destroy
      Rails.logger.info 'Recipe destroyed'
      flash[:notice] = "Recipe deleted correctly."
      redirect_to recipes_path
    else
      Rails.logger.info 'Recipe not destroyed'
      render 'show'
    end
  end
  
  private
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def get_params
    params.require(:recipe).permit(:name, :description)
  end
  
end