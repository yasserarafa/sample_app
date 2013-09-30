#require "sinatra"

require "pocket"
require "embedly"



class SessionsController < ApplicationController

    before_filter :set_callback_url, only: [:pocket_callback,:social_login,:favorite]

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
      # binding.pry
  		access_token = Pocket.get_access_token(session[:code])
      # binding.pry
    	session[:access_token] = access_token
    		#puts "session: #{session}"
    	redirect_to getter_sessions_path
  	end

  	def social_login
  		  session[:code] = Pocket.get_code(:redirect_uri => @CALLBACK_URL)
    		new_url = Pocket.authorize_url(:code => session[:code], :redirect_uri => @CALLBACK_URL)
        # binding.pry
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
      @list.values.each do |i|

        url = i["given_url"]
        x = current_user.articles.find_by_url url
        if x 
          puts "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"
        else
          embedly_api = Embedly::API.new :key => '0d3275c1abf64c6f85ba10c8c197e7ef'
          @obj = embedly_api.extract :url => url

          article = Article.new
          article.user = current_user
          article.title = @obj[0].title
          article.description = @obj[0].description
          article.content = @obj[0].content
          article.item_id = i["item_id"]
          article.favorite = i["favorite"]
          article.url = i["given_url"]
          article.save
        end
      
      end

    end
      	

    def embed
        item_id = params[:item_id]
        @item = current_user.articles.find_by item_id: item_id
    end

    def favorite
        id = params[:id]
        client = Pocket.client(:access_token => session[:access_token])
        client.modify [{:action => :favorite , :item_id => id}]
        current_user.articles.find_by(item_id: id).favorite = 1
        redirect_to getter_sessions_path
    end

    def favorite_sec
        id = params[:item_id]
        url=params[:given_url]
        client = Pocket.client(:access_token => session[:access_token])
        client.modify [{:action => :favorite , :item_id => id}]
        current_user.articles.find_by(item_id: id).favorite = 1
        redirect_to embed_sessions_path(given_url: url,item_id: id, fav: "1")
    end


    def unfavorite
        id = params[:id]
        client = Pocket.client(:access_token => session[:access_token])
        client.modify [{:action => :unfavorite , :item_id => id}]
        current_user.articles.find_by(item_id: id).favorite = 0
        redirect_to getter_sessions_path
    end

    def unfavorite_sec
        id = params[:item_id]
        url=params[:given_url]
        client = Pocket.client(:access_token => session[:access_token])
        client.modify [{:action => :unfavorite , :item_id => id}]
        current_user.articles.find_by(item_id: id).favorite = 0
        redirect_to embed_sessions_path(given_url: url,item_id: id, fav: "0")
    end


    def  archive
         id = params[:id]
        client = Pocket.client(:access_token => session[:access_token])
        client.modify [{:action => :archive , :item_id => id}]
        current_user.articles.find_by(item_id: id).destroy
        redirect_to getter_sessions_path 
    end

    def delete
      id = params[:id]
      client = Pocket.client(:access_token => session[:access_token])
      client.modify [{:action => :delete , :item_id => id}]
      current_user.articles.find_by(item_id: id).destroy
      redirect_to getter_sessions_path 
    end

    def send_to_kindle
      client = Pocket.client(:access_token => session[:access_token])
      info = client.retrieve :detailType => :complete
      list =info["list"] 
      x = String.new
      list.values.each do |i|
        x = x + i["given_title"] + "\n" 

        embedly_api = Embedly::API.new :key => '0d3275c1abf64c6f85ba10c8c197e7ef'
        obj = embedly_api.extract :url => i["given_url"]

        if obj[0].content
          x = x + obj[0].content + "\n"
        end
      end
      
      f = Tempfile.new('ready')
      f.write(x)
      f.rewind
      UserMailer.welcome_email( f, current_user).deliver

      redirect_to getter_sessions_path 

    end     



    def set_callback_url
      @CALLBACK_URL = "#{APP_CONFIG['host']}/sessions/pocket_callback"
    end
  

end