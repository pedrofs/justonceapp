module ProductManagement
  class CategoryProduct < ApplicationRecord
    self.table_name = 'category_products'

    acts_as_tenant :home

    belongs_to :category, class_name: 'ProductManagement::Category'
    belongs_to :product, class_name: 'ProductManagement::Product'
  end
end
