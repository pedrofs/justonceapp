module GroceryList
  class ReadModel
    # rubocop:disable Metrics/AbcSize
    def process_event(event)
      case event
      when GroceryList::Events::ItemAdded
        list_repo.add_item(event.data[:list_id], event.data[:product_id])
      when GroceryList::Events::ItemRemoved
        list_repo.remove_item(event.data[:list_id], event.data[:product_id])
      when GroceryList::Events::ItemBought
        list_repo.buy_item(event.data[:list_id], event.data[:product_id])
      when GroceryList::Events::ListCleared
        list_repo.clear_list(event.data[:list_id])
      end
    end
    # rubocop:enable Metrics/AbcSize

    private

    def list_repo
      @list_repo ||= GroceryList::ListRepository.new
    end
  end
end
