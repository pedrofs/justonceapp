describe GroceryList::Component do
  describe 'initialize' do
    it 'returns a GroceryList::Component' do
      expect(described_class.new(Object.new, Object.new)).to be_a(described_class)
    end
  end

  describe '.boot' do
    context 'with a command bus' do
      subject(:boot) { described_class.new(Object.new, command_bus).boot }

      let(:command_bus) { instance_double('command bus') }

      before do
        allow(command_bus).to receive(:register)
      end

      it 'registers AddItem' do
        handler_double = stub_initialize(GroceryList::Commands::AddItemHandler)

        boot

        expect(command_bus).to(
          have_received(:register).with(GroceryList::Commands::AddItem, handler_double)
        )
      end

      it 'registers RemoveItem' do
        handler_double = stub_initialize(GroceryList::Commands::RemoveItemHandler)

        boot

        expect(command_bus).to(
          have_received(:register).with(GroceryList::Commands::RemoveItem, handler_double)
        )
      end

      it 'registers BuyItem' do
        handler_double = stub_initialize(GroceryList::Commands::BuyItemHandler)

        boot

        expect(command_bus).to(
          have_received(:register).with(GroceryList::Commands::BuyItem, handler_double)
        )
      end

      it 'registers ClearList' do
        handler_double = stub_initialize(GroceryList::Commands::ClearListHandler)

        boot

        expect(command_bus).to(
          have_received(:register).with(GroceryList::Commands::ClearList, handler_double)
        )
      end
    end
  end
end

def stub_initialize(klass)
  handler = instance_double(klass)
  allow(klass).to receive(:new).and_return(handler)

  handler
end
