# To log in and out, you must create sessions for the
# software to know you are logged in/out. 

class SessionsController < ApplicationController

	def new
	end

	# Allows a user to sign in. Checks to see if the user's
	# email and password match. If so, it signs in. 
	# Sign in creates a new session. 
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to root_url
		else
			flash[:error] = 'Invalid email/password combination.'
			render 'new'
		end
	end

	# When you sign out, it destroys the session, telling the
	# forum you are signed out. 
	def destroy
		sign_out
		redirect_to root_url
	end
end