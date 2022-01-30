describe 'GET /api/recipes', type: :request do
  describe 'no recipes to return' do
    before do
      get '/api/recipes'
    end

    it 'is expected to respond with status 404' do
      expect(response.status).to eq 404
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'Recipes not found'
    end
  end
  describe 'successfully' do
    subject { response }
    let!(:recipe1) { create(:recipe, title: 'I can override Factory values here') }
    let!(:recipe2) { create(:recipe, title: 'Yummy pancakes') }

    before do
      get '/api/recipes'
    end

    it 'is expected to respond with status 200' do
      expect(subject.status).to eq 200
    end

    it 'is expected to respond with a recipe' do
      expect(response_json.size).to eq 1
    end

    it 'is expected to respond with a recipe' do
      expect(response_json['recipes'].first['title']).to eq 'I can override Factory values here'
    end

    it 'is expected to respond with a recipe' do
      expect(response_json['recipes'].size).to eq 2
    end
  end
end
