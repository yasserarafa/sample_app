require "embedly"

Embedly.configure do |config|
  # prints debug messages to the logger
  config.debug = true

  # use a custom logger

  # disable typhoeus and use Net::HTTP instead
  config.request_with :net_http
end