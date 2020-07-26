describe GroceryList::Commands::RemoveItemHandler do
  describe '.call' do
    subject(:remove_item_handler) { described_class.new(FakeCommandHandler.new).call(command) }

    let(:command) { OpenStruct.new(aggregate_id: SecureRandom.uuid, product_id: SecureRandom.uuid) }
    let(:list) { GroceryList::List.new(command.aggreate_id) }

    before { list.add_item(command.product_id) }

    it 'calls .with_aggregate from command handler' do
      expect_any_instance_of(FakeCommandHandler).to(
        receive(:with_aggregate).with(GroceryList::List, command.aggregate_id)
      )

      remove_item_handler
    end

    it 'returns ItemAdded from the block call' do
      allow_any_instance_of(FakeCommandHandler).to receive(:with_aggregate) do |&block|
        expect(block.call(list).last).to be_a(GroceryList::Events::ItemRemoved)
      end

      remove_item_handler
    end

    it 'has the right event data' do
      allow_any_instance_of(FakeCommandHandler).to receive(:with_aggregate) do |&block|
        expect(block.call(list).last.data).to eq({ product_id: command.product_id })
      end

      remove_item_handler
    end
  end
end

class FakeCommandHandler
  def with_aggregate(klass, aggregate_id); end
end
