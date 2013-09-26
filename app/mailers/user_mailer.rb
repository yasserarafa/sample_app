class UserMailer < ActionMailer::Base
  default from: "yassoraa88@hotmail.com"

  def welcome_email()
    mail(to: "yassoraa88@gmail.com", subject: '1000 mabrook')
    attachments['RAILS.PNG'] = File.read('/home/yasser/rails apps/sample_app/app/assets/images/rails.png')

  end
end
