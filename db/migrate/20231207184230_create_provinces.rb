class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces do |t|
      t.string :province_name
      t.decimal :tax_rate

      t.timestamps
    end
  end
end
