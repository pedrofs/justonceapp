class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists, id: :uuid do |t|
      t.uuid :home_id
      t.timestamps
    end
  end
end
