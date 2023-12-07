class ChangeTaxRateToPst < ActiveRecord::Migration[7.0]
  def change
    rename_column :provinces, :tax_rate, :pst
  end
end
