#require "sinatra"

require "pocket"
require "embedly"

class SessionsController < ApplicationController
CALLBACK_URL = "http://localhost:3000/sessions/pocket_callback"

	def new

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
    	else
      		flash[:error] = 'Invalid email/password combination' # Not quite right!
      		render 'new'
    	end
	end

	def pocket_callback
		access_token = Pocket.get_access_token(session[:code], :redirect_uri => CALLBACK_URL)
  		session[:access_token] = access_token
  		#puts "session: #{session}"
  		redirect_to getter_sessions_path
	end

	def social_login
		session[:code] = Pocket.get_code(:redirect_uri => CALLBACK_URL)
  		new_url = Pocket.authorize_url(:code => session[:code], :redirect_uri => CALLBACK_URL)
  		puts "new_url: #{new_url}"
  		puts "session: #{session}"
  		redirect_to new_url
	end


	def destroy
    	sign_out
    	redirect_to root_path
  	end

  	def getter
  		client = Pocket.client(:access_token => session[:access_token])
  		info = client.retrieve :detailType => :complete
  		@list = info["list"]
  		# binding.pry

  # html = "<h1>#{user.username}'s recent photos</h1>"
  # for media_item in client.user_recent_media
  #   html << "<img src='#{media_item.images.thumbnail.url}'>"
  # end
  # html	
  	end

    def embed
        url = params[:given_url]
        embedly_api = Embedly::API.new :key => '0d3275c1abf64c6f85ba10c8c197e7ef'
        @obj = embedly_api.extract :url => url
    end


  

end
