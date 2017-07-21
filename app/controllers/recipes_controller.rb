class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:show]
  
  def index
    @recipes = Recipe.all
  end 
  
  def show
    @recipe = set_recipe
  end
  
  private
  
  def set_recipe
    Recipe.find(params[:id])
  end
  
end