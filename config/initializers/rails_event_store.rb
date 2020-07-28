# frozen_string_literal: true

require 'rails_event_store'
require 'aggregate_root'
require 'arkency/command_bus'

Rails.configuration.to_prepare do
  Rails.configuration.event_store = RailsEventStore::Client.new
  Rails.configuration.command_bus = Arkency::CommandBus.new

  AggregateRoot.configure do |config|
    config.default_event_store = Rails.configuration.event_store
  end

  GroceryList::Component.new(Rails.configuration.event_store,
                             Rails.configuration.command_bus,
                             CommandHandler.new)
                        .boot

  Rails.configuration.event_store.tap do |store|
    store.subscribe(GroceryList::ReadModel.new.method(:process_event), to: [
      GroceryList::Events::ItemAdded,
      GroceryList::Events::ItemRemoved,
      GroceryList::Events::ItemBought,
      GroceryList::Events::ListCleared
    ])
  end
end
