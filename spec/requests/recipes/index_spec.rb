describe 'GET /api/recipes' do
  subject { response }

  before do
    get '/api/recipes'
  end

  it 'is expected to respond with status 200' do
    expect(subject.status).to eq 200
  end

  it 'is expected to respond with an empty array' do
    expect(response_json).to eq []
  end
end
