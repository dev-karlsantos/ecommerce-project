class AddReferenceToProvinceInUsers < ActiveRecord::Migration[6.0]
  def up
    add_reference :users, :province, foreign_key: true

    # Migrate existing data from the 'province' column to the new 'province_id' column
    User.reset_column_information
    User.all.each do |user|
      province = user.province
      user.update(province_id: province)
    end

    remove_column :users, :province
  end

  def down
    add_column :users, :province, :string

    # Migrate existing data from the 'province_id' column to the old 'province' column
    User.reset_column_information
    User.all.each do |user|
      province = user.province_id
      user.update(province:)
    end

    remove_reference :users, :province
  end
end
