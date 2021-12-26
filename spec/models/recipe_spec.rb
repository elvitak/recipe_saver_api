RSpec.describe Recipe, type: :model do
  it { is_expected.to have_db_column :title }
  it { is_expected.to have_db_column :ingredients }
  it { is_expected.to have_db_column :instructions }

  it 'is expected to have a valid Factory' do
    expect(create(:recipe)).to be_valid
  end
end
