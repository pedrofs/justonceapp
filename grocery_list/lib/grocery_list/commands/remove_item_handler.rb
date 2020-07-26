module GroceryList
  module Commands
    class RemoveItemHandler < BaseHandler
      def call(command)
        command_handler.with_aggregate(List, command.aggregate_id) do |list|
          list.remove_item(command.product_id)
        end
      end
    end
  end
end
