RSpec.describe Recipe::ShowSerializer, type: :serializer do
  let(:recipe) { create(:recipe) }

  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(recipe, serializer: described_class)
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap data in a key reflecting the resource name' do
    expect(subject.keys).to match ['recipe']
  end

  it 'is expected to contain relevant keys' do
    expected_keys = %w[id title ingredients instructions]
    expect(subject['recipe'].keys).to match expected_keys
  end

  it 'is expected to contain keys with specific data types' do
    expect(subject).to match(
      'recipe' => {
        'id' => an_instance_of(Integer),
        'title' => an_instance_of(String),
        'ingredients' => an_instance_of(Array),
        'instructions' => an_instance_of(Array)
      }
    )
  end
end
