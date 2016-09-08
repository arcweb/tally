class CancelPtoTimeRequest < TimeRequest
  def display_text
    "Cancel PTO"
  end

  def approve
    specific_date = self.requested_days.first.date_requested
    day_to_destroy = VacationDay
                       .includes(:requested_day)
                       .find_by(requested_days: {
                                   date_requested: specific_date
                                 })
    self.approved!
    day_to_destroy.destroy
    RequestStatusMailer.send_status_email('canceled', self).deliver_now
  end

  def deny
    self.denied!
    RequestStatusMailer.send_status_email('denied', self).deliver_now
  end
end
