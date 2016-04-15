class AddStateToProduct < ActiveRecord::Migration
  def change
    add_column :products, :state, :boolean, default: true
  end
end
