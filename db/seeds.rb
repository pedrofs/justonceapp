ActiveRecord::Base.transaction do
  home = Home.create!(name: 'Home Sweet Home')

  hygiene = ProductManagement::Category.create!(name: 'Hygiene', home_id: home.id)
  food = ProductManagement::Category.create!(name: 'Food', home_id: home.id)
  cleaning = ProductManagement::Category.create!(name: 'Cleaning', home_id: home.id)

  ProductManagement::Product.create!(name: 'Cheese', category: food, home_id: home.id)
  ProductManagement::Product.create!(name: 'Teeth Paste', category: hygiene, home_id: home.id)
  ProductManagement::Product.create!(name: 'Cleaning Agent', category: cleaning, home_id: home.id)
end
