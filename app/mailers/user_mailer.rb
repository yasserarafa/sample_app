class UserMailer < ActionMailer::Base
  default from: "noreply@pocket4kindle.com"

  def welcome_email(f)

    # f = File.read('/home/yasser/rails apps/sample_app/ready.html')
    # binding.pry
    attachments["ready.html"] = f

    mail(to: "yassoraa88@gmail.com", subject: 'convert')
    

  end
end
