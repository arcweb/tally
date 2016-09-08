class AddDateRequestedToTimeRequests < ActiveRecord::Migration
  def change
    add_column :time_requests, :date_requested, :date
  end
end
