describe GroceryList::Item do
  describe 'initialize' do
    it 'returns an Item' do
      expect(described_class.new(SecureRandom.uuid)).to be_a(described_class)
    end

    it 'has Item with pending state' do
      expect(described_class.new(SecureRandom.uuid)).to be_pending
    end

    context 'when passing bought state' do
      it 'has Item with bought state' do
        expect(described_class.new(SecureRandom.uuid, :bought)).to be_bought
      end
    end

    context 'when passing invalid state' do
      it 'raises an error' do
        expect { described_class.new(SecureRandom.uuid, :invalid) }.to(
          raise_error(GroceryList::State::InvalidState)
        )
      end
    end
  end
end
