class CreateTimeRequest < ActiveRecord::Migration
  def change
    create_table :time_requests do |t|
      t.string :status
      t.string :type
      t.integer :user_id
    end
  end
end
