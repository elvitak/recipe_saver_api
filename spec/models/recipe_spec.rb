RSpec.describe Recipe, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:ingredient_id).of_type(:integer) }
    it { is_expected.to have_db_column(:instruction_id).of_type(:integer) }
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
end
