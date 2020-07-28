describe GroceryList::ListRepository do
  describe '.current_list' do
    context 'with one list' do
      let(:list) { GroceryList::ListRepository::List.create(home_id: create(:home).id) }

      it 'returns list' do
        list

        expect(described_class.new.current_list).to eq(list)
      end
    end

    context 'without list' do
      it 'returns nil' do
        expect(described_class.new.current_list).to be_nil
      end
    end
  end

  describe '.items' do
    let(:list) { GroceryList::ListRepository::List.create(home_id: create(:home).id) }

    context 'without items' do
      it { expect(described_class.new.items(list)).to be_empty }
    end

    context 'with items' do
      let(:list_item) do
        GroceryList::ListRepository::ListItem.create(list_id: list.id,
                                                     product_id: SecureRandom.uuid)
      end

      it 'returns [list_item]' do
        list_item

        expect(described_class.new.items(list)).to eq([list_item])
      end
    end
  end

  describe '.create_list' do
    subject(:create_list) { described_class.new.create_list }

    before { ActsAsTenant.current_tenant = create(:home) }

    it { expect(create_list).to be_a(GroceryList::ListRepository::List) }
    it { expect { create_list }.to change(GroceryList::ListRepository::List, :count).by(1) }
    it { expect(create_list).to be_persisted }
  end

  describe '.add_item' do
    subject(:add_item) do
      described_class.new.add_item(SecureRandom.uuid, product_id)
    end

    let(:home) { create(:home) }
    let(:category) { create(:category, home: home) }
    let(:product_id) { create(:product, category: category, home: home).id }

    before { ActsAsTenant.current_tenant = home }

    it { expect(add_item).to be_a(GroceryList::ListRepository::ListItem) }
    it { expect { add_item }.to change(GroceryList::ListRepository::ListItem, :count).by(1) }
    it { expect(add_item).to be_persisted }
  end

  describe '.buy_item' do
    subject(:buy_item) do
      described_class.new.buy_item(list_id, product_id)
    end

    let(:home) { create(:home) }
    let(:category) { create(:category, home: home) }
    let(:product_id) { create(:product, category: category, home: home).id }
    let(:list_id) { GroceryList::ListRepository::List.create.id }


    before do
      ActsAsTenant.current_tenant = home
      GroceryList::ListRepository::ListItem.create(list_id: list_id, product_id: product_id)
    end

    it { expect(buy_item).to be_truthy }

    it 'sets bought_at' do
      buy_item

      expect(GroceryList::ListRepository::ListItem.first.bought_at).not_to be_nil
    end
  end

  describe '.clear_list' do
    let(:list) { GroceryList::ListRepository::List.create(home_id: create(:home).id) }

    let(:list_item) do
      GroceryList::ListRepository::ListItem.create(list_id: list.id,
                                                    product_id: SecureRandom.uuid)
    end

    it 'returns [list_item]' do
      described_class.new.clear_list(list.id)

      expect(GroceryList::ListRepository::ListItem.all).to be_empty
    end
  end
end
