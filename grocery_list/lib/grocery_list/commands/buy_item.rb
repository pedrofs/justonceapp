require 'types'
require 'command'

module GroceryList
  module Commands
    class BuyItem < Command
      attribute :product_id, Types::UUID
    end
  end
end
