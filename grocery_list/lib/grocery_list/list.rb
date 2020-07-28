module GroceryList
  class List
    include AggregateRoot

    ListAlreadyBought = Class.new(Error)
    ProductAlreadyOnList = Class.new(Error)
    ProductNotOnList = Class.new(Error)
    ProductAlreadyBought = Class.new(Error)

    delegate :empty?, to: :items

    def initialize(id)
      @id = id
      @items = []
    end

    def add_item(product_id)
      assert_product_not_on_list!(product_id)

      apply(Events::ItemAdded.new(data: { list_id: id, product_id: product_id }))
    end

    def remove_item(product_id)
      assert_product_on_list!(product_id)

      apply(Events::ItemRemoved.new(data: { list_id: id, product_id: product_id }))
    end

    def buy_item(product_id)
      assert_product_on_list!(product_id)
      assert_product_pending!(product_id)

      apply(Events::ItemBought.new(data: { list_id: id, product_id: product_id }))
    end

    def clear
      apply(Events::ListCleared.new(data: { list_id: id }))
    end

    on Events::ItemAdded do |event|
      items << Item.new(event.data[:product_id])
    end

    on Events::ItemRemoved do |event|
      items.delete(Item.new(event.data[:product_id]))
    end

    on Events::ItemBought do |event|
      items.delete(Item.new(event.data[:product_id]))

      items << Item.new(event.data[:product_id], :bought)
    end

    on Events::ListCleared do |_event|
      items.clear
    end

    private

    attr_reader :id, :state, :items

    def assert_product_on_list!(product_id)
      raise ProductNotOnList.new, 'Product not on list' unless item_on_list?(product_id)
    end

    def assert_product_not_on_list!(product_id)
      raise ProductAlreadyOnList.new, 'Product already on list' if item_on_list?(product_id)
    end

    def assert_product_pending!(product_id)
      raise ProductAlreadyBought.new, 'Product already bought' if find_item(product_id)&.bought?
    end

    def item_on_list?(product_id)
      items.include?(Item.new(product_id))
    end

    def find_item(product_id)
      items.find { |i| i.product_id == product_id }
    end
  end
end
