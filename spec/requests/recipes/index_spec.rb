describe 'GET /api/recipes' do
  subject { response }
  let!(:recipe) { create(:recipe, title: 'I can override Factory values here') }

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
    expect(response_json.first['title']).to eq 'I can override Factory values here'
  end
end
