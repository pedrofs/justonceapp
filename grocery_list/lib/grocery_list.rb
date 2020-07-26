module GroceryList
  class Component
    def initialize(event_store, command_bus, command_handler)
      @event_store = event_store
      @command_bus = command_bus
      @command_handler = command_handler
    end

    def boot
      register_commands
      subscribe_events
    end

    private

    attr_reader :event_store, :command_bus, :command_handler

    def register_commands
      command_bus.register(Commands::AddItem, add_item_handler)
      command_bus.register(Commands::RemoveItem, remove_item_handler)
      command_bus.register(Commands::BuyItem, buy_item_handler)
      command_bus.register(Commands::ClearList, clear_list_handler)
    end

    def subscribe_events; end

    def add_item_handler
      Commands::AddItemHandler.new(command_handler)
    end

    def remove_item_handler
      Commands::RemoveItemHandler.new(command_handler)
    end

    def buy_item_handler
      Commands::BuyItemHandler.new(command_handler)
    end

    def clear_list_handler
      Commands::ClearListHandler.new(command_handler)
    end
  end
end
