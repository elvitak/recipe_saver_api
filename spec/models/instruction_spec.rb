RSpec.describe Instruction, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:instruction).of_type(:string) }
  end

  describe 'Associations' do
    it { is_expected.to validate_presence_of :instruction }
    it { is_expected.to belong_to(:recipe) }
  end

  describe 'Factory' do
    it 'is expected to have a valid Factory' do
      expect(create(:recipe)).to be_valid
    end
  end
end
