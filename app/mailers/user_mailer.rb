class UserMailer < ActionMailer::Base
  default from: "noreply@pocket4kindle.com"

  def welcome_email(f)
  	
    attachments["ready.html"] = f.read

    mail(to: "yassoraa88@gmail.com", subject: 'convert')
    

  end
end
