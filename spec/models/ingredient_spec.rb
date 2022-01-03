RSpec.describe Ingredient, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:amount).of_type(:integer) }
    it { is_expected.to have_db_column(:unit).of_type(:string) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'Associations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'Factory' do
    it 'is expected to have a valid Factory' do
      expect(create(:ingredient)).to be_valid
    end
  end
end
