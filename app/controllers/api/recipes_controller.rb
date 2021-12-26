class Api::RecipesController < ApplicationController
  def index
    recipes = Recipe.all
    render json: { recipes: recipes }
  end

  def create
    recipe = Recipe.create(params[:recipe].permit!)
    render json: { recipe: recipe }, status: 201
  end
end
