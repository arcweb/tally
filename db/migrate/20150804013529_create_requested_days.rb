class CreateRequestedDays < ActiveRecord::Migration
  def change
    create_table :requested_days do |t|
      t.date :date_requested
      t.integer :hours_requested
      t.integer :time_request_id
      t.timestamps null: false
    end

    remove_column :time_requests, :date_requested
    remove_column :time_requests, :hours_requested
    remove_column :vacation_days, :date_taken
    remove_column :vacation_days, :hours_taken
    add_column :vacation_days, :requested_day_id, :integer
  end
end
