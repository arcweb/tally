class RequestStatusMailer < ApplicationMailer
  def send_status_email(status, request)
    @status = status
    @request = request
    mail(to: request.user.email, subject: "PTO Request #{status.capitalize}")
  end
end