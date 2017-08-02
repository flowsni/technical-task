class UserMailer < ApplicationMailer
  default from: "example.com"
  
  def send_message(user, message)
    @message = message
    mail(to: user.email, subject: @message)
  end
  
end
