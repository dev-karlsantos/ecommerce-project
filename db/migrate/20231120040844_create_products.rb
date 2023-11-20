class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :categories, null: false, foreign_key: true
      t.string :product_name
      t.float :price
      t.text :description
      t.integer :stock_quantity
      t.string :image_file

      t.timestamps
    end
  end
end
