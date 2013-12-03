class Admin::DashboardController < ApplicationController
	before_filter :authenticate_admin

  	def index

  		# Put some statics here, perhaps?
  	end

    # Make sure only Administrators can access the ACP
    def authenticate_admin
        if !admin?
            flash[:notice] =  "Not an Administrator. Denied."
            redirect_to root_path
        end
    end

end
