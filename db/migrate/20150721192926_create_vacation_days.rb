class CreateVacationDays < ActiveRecord::Migration
  def change
    create_table :vacation_days do |t|
      t.date :date_taken
      t.integer :hours_taken
      t.integer :user_id
      t.integer :time_request_id
    end
  end
end
