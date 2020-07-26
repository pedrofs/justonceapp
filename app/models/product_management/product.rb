module ProductManagement
  class Product < ApplicationRecord
    self.table_name = 'products'

    acts_as_tenant :home

    belongs_to :category, class_name: 'ProductManagement::Category'

    validates :name, presence: true
  end
end
