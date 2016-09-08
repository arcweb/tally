class ApplicationMailer < ActionMailer::Base
  default from: ENV['sender_email']
end
