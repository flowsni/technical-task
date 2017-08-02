class UserMailer < ApplicationMailer
  default from: ENV["SMTP_USERNAME"]
  
  def send_message(user, message)
    @message = message
    mail(to: user.email, subject: @message)
  end
  
end
