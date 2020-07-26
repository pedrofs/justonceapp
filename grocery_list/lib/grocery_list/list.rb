module GroceryList
  class List
    include AggregateRoot

    ListAlreadyBought = Class.new(StandardError)
    ProductAlreadyOnList = Class.new(StandardError)
    ProductNotOnList = Class.new(StandardError)

    delegate :empty?, to: :items

    def initialize(id)
      @id = id
      @items = []
    end

    def add_item(product_id)
      assert_product_not_on_list!(product_id)

      apply(Events::ItemAdded.new(data: { product_id: product_id }))
    end

    def remove_item(product_id)
      assert_product_on_list!(product_id)

      apply(Events::ItemRemoved.new(data: { product_id: product_id }))
    end

    def buy_item(product_id)
      assert_product_on_list!(product_id)

      apply(Events::ItemBought.new(data: { product_id: product_id }))
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

    def item_on_list?(product_id)
      items.include?(Item.new(product_id))
    end
  end
end
