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
      if items.include?(Item.new(product_id))
        raise ProductAlreadyOnList.new, 'Product already on list'
      end

      apply(Events::ItemAddedToList.new(data: { product_id: product_id }))
    end

    def buy_item(product_id)
      raise ProductNotOnList.new, 'Product not on list' unless items.include?(Item.new(product_id))

      apply(Events::ItemBought.new(data: { product_id: product_id }))
    end

    def clear
      apply(Events::ListCleared.new(data: { list_id: id }))
    end

    on Events::ItemAddedToList do |event|
      items << Item.new(event.data[:product_id])
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
  end
end
