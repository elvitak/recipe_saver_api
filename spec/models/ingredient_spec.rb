RSpec.describe Ingredient, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:ingredient).of_type(:string) }
  end

  describe 'Associations' do
    it { is_expected.to validate_presence_of :ingredient }
    it { is_expected.to belong_to(:recipe) }
  end

  describe 'Factory' do
    it 'is expected to have a valid Factory' do
      expect(create(:recipe)).to be_valid
    end
  end
end
