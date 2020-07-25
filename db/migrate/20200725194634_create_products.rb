class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.uuid :home_id

      t.timestamps
    end
  end
end
