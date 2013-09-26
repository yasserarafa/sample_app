class UserMailer < ActionMailer::Base
  default from: "yassoraa88@hotmail.com"

  def welcome_email()
    attachments["rails.png"] = File.read('/home/yasser/rails apps/sample_app/app/assets/images/rails.png')
    
    mail(to: "yassoraa88@gmail.com", subject: '1000 mabrook')
    

  end
end
