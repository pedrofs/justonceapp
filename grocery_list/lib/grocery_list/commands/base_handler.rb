module GroceryList
  module Commands
    class BaseHandler
      def initialize(command_handler)
        @command_handler = command_handler
      end

      protected

      attr_reader :command_handler
    end
  end
end
