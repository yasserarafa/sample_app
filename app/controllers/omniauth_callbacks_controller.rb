class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	
	def pocket
		user = User.find_for_oauth(request.env["omniauth.auth"])
		# binding.pry
	    if user.persisted?
	      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "getPocket"
	      sign_in(user)#, :event => :authentication
	      redirect_to getter_sessions_path
	    else
	      session["devise.github_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end
	end

end
