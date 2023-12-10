class CreateOrderedProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :ordered_products do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :ordered_quantity

      t.timestamps
    end
  end
end
