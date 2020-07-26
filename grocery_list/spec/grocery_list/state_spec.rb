describe GroceryList::State do
  describe 'initialize' do
    context 'when state is valid' do
      it 'returns a State' do
        expect(described_class.new(:pending)).to be_a(described_class)
      end
    end

    context 'when state is invalid' do
      it 'raises InvalidState' do
        expect { described_class.new(:invalid) }.to raise_error(GroceryList::State::InvalidState)
      end
    end
  end

  describe '.pending?' do
    it 'returns true' do
      expect(described_class.new(:pending)).to be_pending
    end

    it 'returns false' do
      expect(described_class.new(:bought)).not_to be_pending
    end
  end

  describe '.bought?' do
    it 'returns true' do
      expect(described_class.new(:bought)).to be_bought
    end

    it 'returns false' do
      expect(described_class.new(:pending)).not_to be_bought
    end
  end
end
