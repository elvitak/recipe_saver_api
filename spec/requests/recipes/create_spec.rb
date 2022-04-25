describe 'POST /api/recipes', type: :request do
  subject { response }

  describe 'successfully' do
    before do
      post '/api/recipes',
           params: {
             recipe: {
               title: 'nom nom',
               ingredients_attributes: [{  amount: 100, unit: 'grams', name: 'sugar' },
                                        { amount: 500, unit: 'grams', name: 'chocolate' }],
               instructions_attributes: [{ instruction: 'mix together' }, { instruction: 'bake' }],
               image: 'data:image/image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAAEBCAMAAAD1kWivAAADAFB'
             }
           }
      @recipe = Recipe.last
    end

    it 'is expected to return status 201' do
      expect(subject.status).to eq 201
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected to attach the image' do
      expect(@recipe.image).to be_attached
    end

    it 'is expected to create an instance of Recipe' do
      expect(@recipe).to_not eq nil
    end

    it 'is expected to return aproval message that recipe was created' do
      expect(response_json['message']).to eq 'Recipe was created successfully'
    end
  end

  describe 'with missing image' do
    before do
      post '/api/recipes',
           params: {
             recipe: {
               title: 'nom nom',
               ingredients_attributes: [{  amount: 100, unit: 'grams', name: 'sugar' },
                                        { amount: 500, unit: 'grams', name: 'chocolate' }],
               instructions_attributes: [{ instruction: 'mix together' }, { instruction: 'bake' }]
             }
           }
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected to respond with an error message' do
      expect(response_json['message']).to eq 'Recipe was created successfully'
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
                 instructions_attributes: [{ instruction: 'mix together' }, { instruction: 'bake' }],
                 image: 'data:image/image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAAEBCAMAAAD1kWivAAADAFB'
               }
             }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq "Title can't be blank"
      end
    end

    describe 'due to missing instructions' do
      before do
        post '/api/recipes',
             params: {
               recipe: {
                 title: 'nom nom',
                 ingredients_attributes: [{ amount: 100, unit: 'grams', name: 'sugar' },
                                          { amount: 500, unit: 'grams', name: 'chocolate' }],
                 image: 'data:image/image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAAEBCAMAAAD1kWivAAADAFB'

               }
             }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq "Instructions can't be blank"
      end
    end

    describe 'due to missing ingredients' do
      before do
        post '/api/recipes',
             params: {
               recipe: {
                 title: 'nom nom',
                 instructions_attributes: [{ instruction: 'mix together' }, { instruction: 'bake' }],
                 image: 'data:image/image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAAEBCAMAAAD1kWivAAADAFB'
               }
             }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq "Ingredients can't be blank"
      end
    end
  end
end
