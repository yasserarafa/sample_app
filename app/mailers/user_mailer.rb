class UserMailer < ActionMailer::Base
  default from: "noreply@pocket4kindle.com"

  def welcome_email(f,user)
    attachments["ready.html"] = f.read

    mail(to: user.email, subject: 'convert')
    

  end
end
