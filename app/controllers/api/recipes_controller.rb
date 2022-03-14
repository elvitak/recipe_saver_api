class Api::RecipesController < ApplicationController
  before_action :validate_params_presence, only: %i[create update]
  rescue_from ActiveRecord::RecordNotFound, with: :render_404_error

  def index
    recipes = Recipe.all

    if recipes.any?
      render json: recipes, each_serializer: Recipe::IndexSerializer
    else
      render json: { recipes: '[]' }
    end
  end

  def create
    recipe = Recipe.create(recipe_params)

    if recipe.persisted?
      render_message('Recipe was created successfully', 201)
    else
      render_message(recipe.errors.full_messages.to_sentence, 422)
    end
  end

  def show
    recipe = Recipe.find(params['id'])
    render json: recipe, serializer: Recipe::ShowSerializer
  rescue ActiveRecord::RecordNotFound => e
    render_message('Recipe not found', 404)
  end

  def destroy
    recipe = Recipe.find(params['id'])
    recipe.destroy
    render_message('You successfully deleted recipe', 202)
  rescue ActiveRecord::RecordNotFound => e
    render_message('Your request can not be processed at this time', 422)
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update(recipe_params)
    render json: { message: 'Your recipe was updated.' }
  end

  private

  def validate_params_presence
    if params[:recipe].nil?
      render_message('Missing params', 422)
    elsif params[:recipe][:title].nil?
      render_message("Title can't be blank", 422)
    elsif params[:recipe][:instructions_attributes].nil?
      render_message("Instructions can't be blank", 422)
    elsif params[:recipe][:ingredients_attributes].nil?
      render_message("Ingredients can't be blank", 422)
    end
  end

  def recipe_params
    params[:recipe].permit(:title, instructions_attributes: [:instruction],
                                   ingredients_attributes: %i[amount unit name])
  end

  def render_message(message, status)
    render json: { message: message }, status: status
  end

  def render_404_error
    render json: { message: 'Recipe not found' }, status: 404
  end
end
