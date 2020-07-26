module ProductManagement
  class Category < ApplicationRecord
    acts_as_tenant :home

    has_many :products, class_name: 'ProductManagement::Product'

    validates :name, presence: true
  end
end
