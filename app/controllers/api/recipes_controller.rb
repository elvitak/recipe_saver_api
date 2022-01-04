class Api::RecipesController < ApplicationController
  before_action :validate_params_presence, only: [:create]

  def index
    recipes = Recipe.all
    render json: { recipes: recipes }
  end

  def create
    recipe = Recipe.create(recipe_params)
    binding.pry

    if recipe.persisted?
      render json: { recipe: recipe }, status: 201
    else
      render json: { message: recipe.errors.full_messages.to_sentence }, status: 422
    end
  end

  def show
    recipe = Recipe.find(params['id'])
    render json: { recipe: recipe }
  end

  private

  def validate_params_presence
    render json: { message: 'Missing params' }, status: 422 if params[:recipe].nil?
  end

  def recipe_params
    params[:recipe].permit(:title, instructions_attributes: [[:instruction]],
                                   ingredients_attributes: [%i[amount unit name]])
  end
end
