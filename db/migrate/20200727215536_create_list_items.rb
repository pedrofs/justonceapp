class CreateListItems < ActiveRecord::Migration[6.0]
  def change
    create_table :list_items, id: :uuid do |t|
      t.string :product_name
      t.datetime :bought_at
      t.uuid :product_id
      t.uuid :list_id

      t.timestamps
    end
  end
end
