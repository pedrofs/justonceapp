module ProductManagement
  class Category < ApplicationRecord
    acts_as_tenant :home

    has_many :category_products, class_name: 'ProductManagement::CategoryProduct'
    has_many :products, through: :category_products, class_name: 'ProductManagement::Product'

    validates :name, presence: true
  end
end
