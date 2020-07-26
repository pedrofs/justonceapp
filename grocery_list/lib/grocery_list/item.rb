module GroceryList
  class Item
    delegate :pending?, :bought?, to: :state

    attr_reader :product_id

    def initialize(product_id, state = :pending)
      @product_id = product_id
      @state = State.new(state)
    end

    def ==(other)
      product_id == other.product_id
    end

    private

    attr_reader :state
  end
end
