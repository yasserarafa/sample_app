class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email()
   
    @url  = 'http://example.com/login'
    mail(to: "yassoraa88@yahoo.com", subject: 'Welcome to My Awesome Site')
  end
end
