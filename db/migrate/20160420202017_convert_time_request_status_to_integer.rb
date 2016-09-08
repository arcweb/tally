class ConvertTimeRequestStatusToInteger < ActiveRecord::Migration
  def up
    TimeRequest.all.each do |request|
      status = case request.status
      when "pending"
        0
      when "approved"
        1
      when "denied"
        2
      when "cleared"
        3
      else
        0
      end
        
      request.update_attribute(:status, status)
    end

    change_column :time_requests, :status, 'integer USING CAST (status AS integer)'
  end

  def down
    change_column :time_requests, :status, :string

    TimeRequest.all.each do |request|
      status = case request.status
      when 0
        'pending'
      when 1
        "approved"
      when 2
        "denied"
      when 3
        'cleared'
      else
        'pending'
      end
      request.update_attribute(:status, status)
    end
  end
end
