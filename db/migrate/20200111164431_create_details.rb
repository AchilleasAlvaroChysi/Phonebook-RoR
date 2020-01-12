class CreateDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :details do |t|
      t.integer :phone
      t.string :address

      t.timestamps
    end
  end
end
