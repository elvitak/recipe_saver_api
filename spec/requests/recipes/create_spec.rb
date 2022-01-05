describe 'POST /api/recipes', type: :request do
  subject { response }

  describe 'successfully' do
    before do
      post '/api/recipes',
           params: {
             recipe: {
               title: 'nom nom',
               ingredients_attributes: [{  amount: 100, unit: 'grams', name: 'sugar' },
                                        {  amount: 500, unit: 'grams', name: 'chocolate' }],
               instructions_attributes: [{ instruction: 'mix together' }, { instruction: 'bake' }]
             }
           }
    end

    it 'is expected to return status 201' do
      expect(subject.status).to eq 201
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected to create an instance of Recipe' do
      expect(Recipe.last).to_not eq nil
    end

    it 'is expected to return the new object with a title' do
      expect(response_json['title']).to eq 'nom nom'
    end

    it 'is expected to return the new object with recipe ingredients' do
      expect(response_json['ingredients']).to eq [{ 'amount' => 100, 'name' => 'sugar', 'unit' => 'grams' },
                                                  { 'amount' => 500, 'name' => 'chocolate', 'unit' => 'grams' }]
    end

    it 'is expected to return the new object with recipe ingredients' do
      expect(response_json['instructions']).to eq [{ 'instruction' => 'mix together' }, { 'instruction' => 'bake' }]
    end
  end

  describe 'unsuccessfully' do
    describe 'due to missing params' do
      before do
        post '/api/recipes', params: {}
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq 'Missing params'
      end
    end

    describe 'due to missing title' do
      before do
        post '/api/recipes',
             params: {
               recipe: {
                 ingredients_attributes: [{ amount: 100, unit: 'grams', name: 'sugar' },
                                          { amount: 500, unit: 'grams', name: 'chocolate' }],
                 instructions_attributes: [{ instruction: 'mix together' }, { instruction: 'bake' }]
               }
             }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq "Title can't be blank"
      end
    end
  end
end
