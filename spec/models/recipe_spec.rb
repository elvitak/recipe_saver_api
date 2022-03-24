RSpec.describe Recipe, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
  end

  describe 'Associations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to have_many(:instructions) }
    it { is_expected.to have_many(:ingredients) }
  end

  describe 'Factory' do
    it 'is expected to have be valid' do
      expect(create(:recipe)).to be_valid
    end
  end

  describe 'Image' do
    it 'is expected to be attached' do
      subject.image.attach(
        io: File.open(fixture_path + 'carbonara.jpeg'),
        filename: 'carbonara.jpeg',
        content_type: 'image/jpeg'
      )
      expect(subject.image).to be_attached
    end
  end
end
