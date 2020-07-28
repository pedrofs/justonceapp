module GroceryList
  class ListRepository
    def current_list
      List.first
    end

    def items(list)
      ListItem.where(list_id: list.id)
    end

    def create_list
      List.create
    end

    def add_item(list_id, product_id)
      ListItem.create(product_name: ProductManagement::Product.find(product_id).name,
                      list_id: list_id,
                      product_id: product_id)
    end

    def buy_item(list_id, product_id)
      ListItem.find_by(list_id: list_id, product_id: product_id)&.update(bought_at: Time.current)
    end

    def remove_item(list_id, product_id)
      ListItem.find_by(list_id: list_id, product_id: product_id)&.destroy
    end

    def clear_list(list_id)
      ListItem.where(list_id: list_id).delete_all
    end

    class List < ApplicationRecord
      self.table_name = 'lists'

      acts_as_tenant :home
    end

    class ListItem < ApplicationRecord
      self.table_name = 'list_items'
    end
  end
end
