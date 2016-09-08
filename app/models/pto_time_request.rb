class PtoTimeRequest < TimeRequest
  # Instance Methods
  # ============================================
  def display_text
    "PTO"
  end

  def approve
    self.approved!
    requested_days.each do |day|
      VacationDay.create(requested_day: day, user: user, time_request: self)
    end
    RequestStatusMailer.send_status_email('approved', self).deliver_now
  end

  def deny
    self.denied!
    RequestStatusMailer.send_status_email('denied', self).deliver_now
  end
end