ActiveRecord::Base.transaction do
  home = Home.create!(name: 'Home Sweet Home')

  hygiene = ProductManagement::Category.create!(name: 'Hygiene', home_id: home.id)
  food = ProductManagement::Category.create!(name: 'Food', home_id: home.id)
  cleaning = ProductManagement::Category.create!(name: 'Cleaning', home_id: home.id)

  cheese = ProductManagement::Product.create!(name: 'Cheese', home_id: home.id)
  paste = ProductManagement::Product.create!(name: 'Teeth Paste', home_id: home.id)
  agent = ProductManagement::Product.create!(name: 'Cleaning Agent', home_id: home.id)

  ProductManagement::CategoryProduct.create!(category: food, product: cheese, home_id: home.id)
  ProductManagement::CategoryProduct.create!(category: hygiene, product: paste, home_id: home.id)
  ProductManagement::CategoryProduct.create!(category: cleaning, product: agent, home_id: home.id)
end
