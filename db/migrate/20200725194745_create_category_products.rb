class CreateCategoryProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :category_products do |t|
      t.uuid :category_id
      t.uuid :product_id
      t.uuid :home_id

      t.timestamps
    end
  end
end
