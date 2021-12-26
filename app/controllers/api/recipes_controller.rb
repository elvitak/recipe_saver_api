class Api::RecipesController < ApplicationController
  before_action :validate_params_presence, only: [:create]

  def index
    recipes = Recipe.all
    render json: { recipes: recipes }
  end

  def create
    recipe = Recipe.create(params[:recipe].permit!)
    render json: { recipe: recipe }, status: 201
  end

  private

  def validate_params_presence
    render json: { message: 'Missing params' }, status: 422 if params[:recipe].nil?
  end
end
