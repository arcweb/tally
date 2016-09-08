class AddHoursRequestedToTimeRequest < ActiveRecord::Migration
  def change
    add_column :time_requests, :hours_requested, :integer
    add_column :time_requests, :reason, :text
  end
end
