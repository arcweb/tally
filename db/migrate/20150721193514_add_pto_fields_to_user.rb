class AddPtoFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :available_pto, :integer
    add_column :users, :used_pto, :integer, default: 0
    add_column :users, :carryover_pto, :integer, default: 0
    add_column :users, :bonus_pto, :integer, default: 0
  end
end
