describe ProductManagement::CategoryProduct do
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:product) }
  end
end
