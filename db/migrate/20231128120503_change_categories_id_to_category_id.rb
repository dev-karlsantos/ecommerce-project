class ChangeCategoriesIdToCategoryId < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :categories_id, :category_id
  end
end
