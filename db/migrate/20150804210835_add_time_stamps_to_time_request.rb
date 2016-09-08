class AddTimeStampsToTimeRequest < ActiveRecord::Migration
  def change
    add_column(:time_requests, :created_at, :datetime)
    add_column(:time_requests, :updated_at, :datetime)
  end
end
