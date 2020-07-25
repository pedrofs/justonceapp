describe ProductManagement::Product do
  describe 'associations' do
    it { is_expected.to have_many(:category_products) }
    it { is_expected.to have_many(:categories) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
