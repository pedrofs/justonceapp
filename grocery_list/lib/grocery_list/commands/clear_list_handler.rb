module GroceryList
  module Commands
    class ClearListHandler < BaseHandler
      def call(command)
        command_handler.with_aggregate(List, command.aggregate_id, &:clear)
      end
    end
  end
end
