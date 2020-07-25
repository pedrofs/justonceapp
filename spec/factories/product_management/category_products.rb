FactoryBot.define do
  factory :category_product, class: 'OrderManagement::CategoryProduct' do
    category_id { '' }
    product_id { '' }
    home_id { '' }
  end
end
