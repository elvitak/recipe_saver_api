RSpec.describe 'DELETE /api/recipes', type: :request do
  describe 'successful' do
    let(:recipe) { create(:recipe, title: 'to be deleted') }
    before { delete "/api/recipes/#{recipe.id}" }

    it 'is expected to respond with status 202' do
      expect(response.status).to eq 202
    end

    it 'is expected to return a message' do
      expect(response_json['message']).to eq('You successfully deleted recipe')
    end

    it 'is expected to delete the participant' do
      expect(Recipe.find_by_id(recipe.id)).to be nil
    end
  end

  describe 'unsuccessful' do
    before { delete '/api/recipes/non_exisiting_recipe' }

    it 'is expected to respond with status 422' do
      expect(response.status).to eq 404
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq('Recipe not found')
    end
  end
end
