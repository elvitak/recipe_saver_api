RSpec.describe 'GET/api/recipes/:id', type: :request do
  describe 'successfully' do
    let!(:recipe) do
      create(:recipe, title: 'Pancakes',
                      ingredients: %w[egg milk sugar],
                      instructions: ['first step', 'second step'])
    end

    before do
      get "/api/recipes/#{recipe.id}"
    end

    it 'is expected to return a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return the requested recipes title' do
      expect(response_json['recipe']['title']).to eq 'Pancakes'
    end

    it 'is expected to return the requested recipes ingredients' do
      expect(response_json['recipe']['ingredients']).to eq %w[egg milk sugar]
    end
  end
end
