class AddAgeBasicInfoAdressToUser < ActiveRecord::Migration
  def change
    add_column :users, :age, :number
    add_column :users, :basic_info, :text
    add_column :users, :address, :address
  end
end
