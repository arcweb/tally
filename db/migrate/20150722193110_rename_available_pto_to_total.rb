class RenameAvailablePtoToTotal < ActiveRecord::Migration
  def change
    rename_column :users, :available_pto, :total_pto
  end
end
