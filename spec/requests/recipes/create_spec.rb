describe 'POST /api/recipes' do
  subject { response }

  describe 'successfully' do
    before do
      post '/api/recipes',
           params: {
             recipe: {
               title: 'nom nom',
               ingredients: ['sugar', 'egg whites', 'joy'],
               instructions: ['do some maggic', 'make it work']
             }
           }
    end

    it 'is expected to return status 201' do
      expect(subject.status).to eq 201
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected to return the new object with a title' do
      expect(response_json['recipe']['title']).to eq 'nom nom'
    end

    it 'is expected to return the new object with recipe ingredients' do
      expect(response_json['recipe']['ingredients']).to eq ['sugar', 'egg whites', 'joy']
    end
  end

  describe 'unsuccessfully' do
  end
end
