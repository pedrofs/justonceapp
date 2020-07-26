module GroceryList
  module Commands
    class BuyItemHandler < BaseHandler
      def call(command)
        command_handler.with_aggregate(List, command.aggregate_id) do |list|
          list.buy_item(command.product_id)
        end
      end
    end
  end
end
