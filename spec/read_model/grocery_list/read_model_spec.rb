describe GroceryList::ReadModel do
  describe '.process_event' do
    context 'when ItemAdded' do
      it 'calls repo.add_item' do
        expect_any_instance_of(GroceryList::ListRepository).to receive(:add_item)

        described_class.new.process_event(GroceryList::Events::ItemAdded.new)
      end
    end

    context 'when ItemRemoved' do
      it 'calls repo.remove_item' do
        expect_any_instance_of(GroceryList::ListRepository).to receive(:remove_item)

        described_class.new.process_event(GroceryList::Events::ItemRemoved.new)
      end
    end

    context 'when ItemBought' do
      it 'calls repo.buy_item' do
        expect_any_instance_of(GroceryList::ListRepository).to receive(:buy_item)

        described_class.new.process_event(GroceryList::Events::ItemBought.new)
      end
    end

    context 'when ListCleared' do
      it 'calls repo.clear_list' do
        expect_any_instance_of(GroceryList::ListRepository).to receive(:clear_list)

        described_class.new.process_event(GroceryList::Events::ListCleared.new)
      end
    end
  end
end
