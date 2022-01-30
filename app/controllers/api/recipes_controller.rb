class Api::RecipesController < ApplicationController
  before_action :validate_params_presence, only: [:create]

  def index
    recipes = Recipe.all
    render json: recipes, each_serializer: Recipe::IndexSerializer
  end

  def create
    recipe = Recipe.create(recipe_params)

    if recipe.persisted?
      render_message('Recipe was created successfully', 201)
    else
      render json: { message: recipe.errors.full_messages.to_sentence }, status: 422
    end
  end

  def show
    recipe = Recipe.find(params['id'])
    render json: recipe, serializer: Recipe::ShowSerializer
  rescue ActiveRecord::RecordNotFound => e
    render_message('Recipe not found', 404)
  end

  private

  def validate_params_presence
    render json: { message: 'Missing params' }, status: 422 if params[:recipe].nil?
  end

  def recipe_params
    params[:recipe].permit(:title, instructions: [], ingredients: [])
  end

  def render_message(message, status)
    render json: { message: message }, status: status
  end
end
