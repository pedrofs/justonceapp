require 'types'
require 'command'

module GroceryList
  module Commands
    class AddItem < Command
      attribute :product_id, Types::UUID
    end
  end
end
