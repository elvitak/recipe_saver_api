RSpec.describe 'PUT /api/recipes/:id', type: :request do
  let!(:ingredient1) do
    create(:ingredient, {
             "amount": 100,
             "unit": 'ml',
             "name": 'milk'
           })
  end
  let!(:instruction1) do
    create(:instruction, { "instruction": 'mix together' })
  end
  let!(:instruction2) do
    create(:instruction, { "instruction": 'mix together' })
  end
  let!(:instruction3) do
    create(:instruction, { "instruction": 'mix together' })
  end
  let(:recipe) do
    create(
      :recipe,
      ingredients: [ingredient1],
      instructions: [instruction1, instruction2, instruction3]
    )
  end

  subject { response }

  describe 'successfully' do
    before do
      put "/api/recipes/#{recipe.id}", params: {
        recipe: {
          title: 'new recipe',
          ingredients_attributes: [
            { id: ingredient1.id, amount: 100, unit: 'ml', name: 'milk' },
            { amount: 10, unit: 'grams', name: 'sugar' },
            { amount: 500, unit: 'grams', name: 'chocolate' }
          ],
          instructions_attributes: [
            { instruction: 'bake 20 min' },
            { instruction: 'mix together' },
            { id: instruction1.id, _destroy: true },
            { id: instruction2.id, _destroy: true },
            { id: instruction3.id, _destroy: true }
          ]
        }
      }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to responde with a message' do
      expect(response_json['message']).to eq 'Your recipe was updated.'
    end

    it 'is expected to update an instance of Recipe' do
      expect(Recipe.last.title).to eq 'new recipe'
    end

    it 'is expected to update an instance of Recipe with right ingredients' do
      ingredients = Recipe.last.ingredients.map do |i|
        { amount: i.amount, unit: i.unit, name: i.name }
      end
      expect(ingredients).to eq [
        { amount: 100, unit: 'ml', name: 'milk' },
        { amount: 10, unit: 'grams', name: 'sugar' },
        { amount: 500, unit: 'grams', name: 'chocolate' }
      ]
    end

    # it 'is expected to update an instance of Recipe with right instructions' do
    #   instructions = Recipe.last.instructions.map do |i|
    #     { instruction: i.instruction }
    #   end
    #   expect(instructions).to eq [
    #     { instruction: 'mix together' },
    #     { instruction: 'bake 20 min' }
    #   ]
    # end
  end

  describe 'unsuccessfully' do
    describe 'with non-existent id' do
      before do
        put '/api/recipes/9999999', params: { recipe: {
          title: 'new recipe',
          ingredients_attributes: [
            { amount: 10, unit: 'grams', name: 'sugar' },
            { amount: 500, unit: 'grams', name: 'chocolate' }
          ],
          instructions_attributes: [
            { instruction: 'mix together' },
            { instruction: 'bake 20 min' }
          ]
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
          ingredients_attributes: [
            { amount: 10, unit: 'grams', name: 'sugar' },
            { amount: 500, unit: 'grams', name: 'chocolate' }
          ],
          instructions_attributes: [
            { instruction: 'mix together' },
            { instruction: 'bake 20 min' }
          ]
        } }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq "Title can't be blank"
      end
    end
  end
end
