class SickTimeRequest < TimeRequest
  # Instance Methods
  # ============================================
  after_create :create_vacation_days

  def create_vacation_days
    requested_days.each do |day|
      VacationDay.create(requested_day: day, user: user, time_request: self)
    end
  end

  def display_text
    "Sick"
  end
end