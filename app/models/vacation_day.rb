class VacationDay < ActiveRecord::Base
  # Relationships
  # ============================================
  belongs_to :requested_day
  belongs_to :user
  belongs_to :time_request

  # Instance Methods
  # ============================================
  def month?(month)
    requested_day.date_requested.strftime("%b") == month
  end

  def year
    requested_day.date_requested.year
  end

  def is_current_year?
    self.year == Date.today.year 
  end

  def days_requested
    requested_day.hours_requested == 8 ? 1 : 0.5
  end

  def date_requested
    requested_day.date_requested
  end
end