class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name
      t.uuid :home_id

      t.timestamps
    end
  end
end
