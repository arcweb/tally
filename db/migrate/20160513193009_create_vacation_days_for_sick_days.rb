class CreateVacationDaysForSickDays < ActiveRecord::Migration
  def up
    SickTimeRequest.all.each do |time_request| 
      time_request.create_vacation_days
    end
  end

  def down
    SickTimeRequest.all.each do |time_request| 
      VacationDay.where(time_request: time_request).each do |v| 
        v.destroy
      end
    end
  end
end
