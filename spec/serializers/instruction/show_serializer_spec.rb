RSpec.describe Instruction::ShowSerializer, type: :serializer do
  let(:instruction) { create(:instruction) }

  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new(instruction, serializer: described_class)
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap data in a key reflecting the resource name' do
    expect(subject.keys).to match ['instruction']
  end

  it 'is expected to contain keys with specific data types' do
    expect(subject).to match(
      'instruction' => {
        'id' => an_instance_of(Integer),
        'instruction' => an_instance_of(String)
      }
    )
  end
end
