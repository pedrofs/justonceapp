require 'types'
require 'command'

module GroceryList
  module Commands
    class ClearList < Command
      attribute :list_id, Types::UUID
    end
  end
end
