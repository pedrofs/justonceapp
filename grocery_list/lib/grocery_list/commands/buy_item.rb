require 'types'
require 'command'

module GroceryList
  module Commands
    class BuyItem < Command
      attribute :list_id, Types::UUID
      attribute :product_id, Types::UUID

      alias :aggregate_id :list_id
    end
  end
end
