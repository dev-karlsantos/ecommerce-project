class RenameAboutPagestoPages < ActiveRecord::Migration[7.0]
  def change
    rename_table :about_pages, :pages
  end
end
