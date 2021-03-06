class TimeRequestMailer < ApplicationMailer
  def send_new_request(time_request)
    @time_request = time_request
    subject = ENV['server'] ? "#{ENV['server']}- New Time Request" : "New Time Request"
    mail(to: ENV['recipient_email'], subject: subject, from: time_request.user.email)
  end
end
