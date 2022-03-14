RSpec.describe 'PUT /api/recipes/:id', type: :request do
  let(:recipe) { create(:recipe) }

  subject { response }

  describe 'successfully' do
    before do
      put "/api/recipes/#{recipe.id}", params: {
        recipe: {
          title: 'new recipe',
          ingredients_attributes: [{  amount: 10, unit: 'grams', name: 'sugar' },
                                   { amount: 500, unit: 'grams', name: 'chocolate' }],
          instructions_attributes: [{ instruction: 'mix together' }, { instruction: 'bake 20 min' }]
        }
      }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to responde with a message' do
      expect(response_json['message']).to eq 'Your recipe was updated.'
    end

    it 'is expected to create an instance of Recipe' do
      expect(Recipe.last.title).to eq 'new recipe'
    end
  end

  describe 'unsuccessfully' do
    describe 'with non-existent id' do
      before do
        put '/api/recipes/9999999', params: { recipe: {
          title: 'new recipe',
          ingredients_attributes: [{  amount: 10, unit: 'grams', name: 'sugar' },
                                   { amount: 500, unit: 'grams', name: 'chocolate' }],
          instructions_attributes: [{ instruction: 'mix together' }, { instruction: 'bake 20 min' }]
        } }
      end

      it { is_expected.to have_http_status 404 }

      it 'is expected to respond with error message' do
        expect(response_json['message']).to eq 'Recipe not found'
      end
    end

    describe 'due to missing title' do
      before do
        put "/api/recipes/#{recipe.id}", params: { recipe: {
          ingredients_attributes: [{  amount: 10, unit: 'grams', name: 'sugar' },
                                   { amount: 500, unit: 'grams', name: 'chocolate' }],
          instructions_attributes: [{ instruction: 'mix together' }, { instruction: 'bake 20 min' }]
        } }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq "Title can't be blank"
      end
    end
  end
end
