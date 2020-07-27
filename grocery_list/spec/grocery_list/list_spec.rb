describe GroceryList::List do
  let(:list_id) { SecureRandom.uuid }
  let(:list) { described_class.new(list_id) }

  describe 'initialize' do
    it 'returns a new List' do
      expect(list).to be_a(described_class)
    end

    it 'is empty' do
      expect(list).to be_empty
    end
  end

  describe '.add_item' do
    it 'publishes ItemAdded' do
      expect(list.add_item(SecureRandom.uuid).first).to be_a(GroceryList::Events::ItemAdded)
    end

    it 'has published event data with product_id' do
      product_id = SecureRandom.uuid

      expect(list.add_item(product_id).first.data).to(
        eq({ list_id: list_id, product_id: product_id })
      )
    end

    context 'when product_id is already in the list' do
      it 'raises ProductAlreadyOnList' do
        product_id = SecureRandom.uuid
        list.add_item(product_id)

        expect { list.add_item(product_id) }.to raise_error(GroceryList::List::ProductAlreadyOnList)
      end
    end
  end

  describe '.remove_item' do
    it 'publishes ItemRemoved' do
      product_id = SecureRandom.uuid
      list.add_item(product_id)
      expect(list.remove_item(product_id).first).to be_a(GroceryList::Events::ItemRemoved)
    end

    it 'has published event data with product_id' do
      product_id = SecureRandom.uuid
      list.add_item(product_id)

      expect(list.remove_item(product_id).first.data).to(
        eq({ list_id: list_id, product_id: product_id })
      )
    end

    context 'when product_id is not in the list' do
      it 'raises ProductNotOnList' do
        expect { list.remove_item(SecureRandom.uuid) }.to(
          raise_error(GroceryList::List::ProductNotOnList)
        )
      end
    end

    context 'when adding a product after removing it' do
      it 'publishes ItemAdded' do
        product_id = SecureRandom.uuid
        list.add_item(product_id)
        list.remove_item(product_id)

        expect(list.add_item(product_id).first).to be_a(GroceryList::Events::ItemAdded)
      end
    end
  end

  describe '.buy_item' do
    it 'publishes ItemBought' do
      product_id = SecureRandom.uuid
      list.add_item(product_id)

      expect(list.buy_item(product_id).first).to be_a(GroceryList::Events::ItemBought)
    end

    it 'has published event data with product_id' do
      product_id = SecureRandom.uuid
      list.add_item(product_id)

      expect(list.buy_item(product_id).first.data).to(
        eq({ list_id: list_id, product_id: product_id })
      )
    end

    context 'when item is not in the list' do
      it 'raises ProductNotOnList' do
        expect { list.buy_item(SecureRandom.uuid) }.to raise_error(
          GroceryList::List::ProductNotOnList
        )
      end
    end

    context 'when adding a product that was previously bought' do
      it 'raises ProductAlreadyOnList' do
        product_id = SecureRandom.uuid
        list.add_item(product_id)
        list.buy_item(product_id)

        expect { list.add_item(product_id) }.to raise_error(GroceryList::List::ProductAlreadyOnList)
      end
    end
  end

  describe '.clear' do
    it 'publishes ListCleared' do
      expect(list.clear.first).to be_a(GroceryList::Events::ListCleared)
    end

    it 'has published event data with list_id' do
      expect(list.clear.first.data).to eq({ list_id: list_id })
    end

    context 'when add an item, clearing the list and add item again' do
      it 'add_item for the second time successfuly' do
        product_id = SecureRandom.uuid
        list.add_item(product_id)
        list.clear
        expect(list.add_item(product_id).first).to be_a(GroceryList::Events::ItemAdded)
      end
    end
  end
end
