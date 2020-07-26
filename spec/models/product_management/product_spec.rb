describe ProductManagement::Product do
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
