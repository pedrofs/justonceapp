module GroceryList
  class Component
    def initialize(event_store, command_bus)
      @event_store = event_store
      @command_bus = command_bus
    end

    def boot
      register_commands
      subscribe_events
    end

    private

    attr_reader :event_store, :command_bus

    def register_commands
      command_bus.register(Commands::AddItem, Commands::AddItemHandler.new)
      command_bus.register(Commands::RemoveItem, Commands::RemoveItemHandler.new)
      command_bus.register(Commands::BuyItem, Commands::BuyItemHandler.new)
      command_bus.register(Commands::ClearList, Commands::ClearListHandler.new)
    end

    def subscribe_events; end
  end
end
