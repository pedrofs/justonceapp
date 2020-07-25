class Category < ApplicationRecord
  acts_as_tenant :home

  validates :name, presence: true
end
