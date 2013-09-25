# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
SampleApp::Application.initialize!

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_url_options = { :host => 'quality-cloud.herokuapp.com' }  
ActionMailer::Base.perform_deliveries = true


ActionMailer::Base.server_settings = {
   :address =>  "smtp.sendgrid.net",
   :port => 587,
   :domain => "172.16.20.110",
   :authentication => "plain",
   :user_name => "yassoraa88",
   :password => "yasser_24111988",
}
