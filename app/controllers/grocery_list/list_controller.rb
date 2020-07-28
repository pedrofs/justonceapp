module GroceryList
  class ListController < ApplicationController
    before_action :ensure_list_exists, only: [:show]

    rescue_from GroceryList::Error do |e|
      redirect_to (request.referrer || list_path), alert: e.message
    end

    def show
      @items = list_repo.items(list_repo.current_list)
    end

    def add_item
      command_bus.(add_item_command)

      redirect_to grocery_list_list_path
    end

    def remove_item
      command_bus.(remove_item_command)

      redirect_to grocery_list_list_path
    end

    def buy_item
      command_bus.(buy_item_command)

      redirect_to grocery_list_list_path
    end

    def clear_list
      command_bus.(clear_list_command)

      redirect_to grocery_list_list_path
    end

    private

    def add_item_command
      GroceryList::Commands::AddItem.new(list_id: list_repo.current_list.id,
                                         product_id: params[:product_id])
    end

    def remove_item_command
      GroceryList::Commands::RemoveItem.new(list_id: list_repo.current_list.id,
                                            product_id: params[:product_id])
    end

    def buy_item_command
      GroceryList::Commands::BuyItem.new(list_id: list_repo.current_list.id,
                                         product_id: params[:product_id])
    end

    def clear_list_command
      GroceryList::Commands::ClearList.new(list_id: list_repo.current_list.id)
    end

    def ensure_list_exists
      list_repo.current_list || list_repo.create_list
    end

    def list_repo
      @list_repo ||= ListRepository.new
    end
  end
end
