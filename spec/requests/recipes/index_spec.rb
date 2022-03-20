describe 'GET /api/recipes', type: :request do
  describe 'no recipes to return' do
    before do
      get '/api/recipes'
    end

    it 'is expected to respond with status 200' do
      expect(response.status).to eq 200
    end

    it 'is expected to return an empty array' do
      expect(response_json['recipes']).to eq []
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

  describe 'successfully - with random recipes' do
    subject { response }
    let!(:recipe1) { create(:recipe, title: 'Cake') }
    let!(:recipe2) { create(:recipe, title: 'Meat') }
    let!(:recipe3) { create(:recipe, title: 'Soup') }

    before do
      get '/api/recipes', params: {
        random_sample_size: 2
      }
    end

    it 'is expected to respond with status 200' do
      expect(subject.status).to eq 200
    end

    it 'is expected to respond with 2 recipe' do
      expect(response_json.size).to eq 2
    end
  end
end
