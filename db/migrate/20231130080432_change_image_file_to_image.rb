class ChangeImageFileToImage < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :image_file, :image
  end
end
