describe GroceryList::Commands::BuyItemHandler do
  describe '.call' do
    subject(:buy_item_handler) { described_class.new(FakeCommandHandler.new).call(command) }

    let(:command) { OpenStruct.new(aggregate_id: SecureRandom.uuid, product_id: SecureRandom.uuid) }
    let(:list) { GroceryList::List.new(command.aggregate_id) }
    let(:event_data) { { list_id: command.aggregate_id, product_id: command.product_id } }

    before { list.add_item(command.product_id) }

    it 'calls .with_aggregate from command handler' do
      expect_any_instance_of(FakeCommandHandler).to(
        receive(:with_aggregate).with(GroceryList::List, command.aggregate_id)
      )

      buy_item_handler
    end

    it 'returns ItemAdded from the block call' do
      allow_any_instance_of(FakeCommandHandler).to receive(:with_aggregate) do |&block|
        expect(block.call(list).last).to be_a(GroceryList::Events::ItemBought)
      end

      buy_item_handler
    end

    it 'has the right event data' do
      allow_any_instance_of(FakeCommandHandler).to receive(:with_aggregate) do |&block|
        expect(block.call(list).last.data).to eq(event_data)
      end

      buy_item_handler
    end
  end
end

class FakeCommandHandler
  def with_aggregate(klass, aggregate_id); end
end
