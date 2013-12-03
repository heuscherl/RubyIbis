class Admin::StylesheetsController < ApplicationController
	    before_filter :authenticate_admin, :except => [:show]

        respond_to :css

    caches_page :show # magic happens here

    def index
        @stylesheets = Stylesheet.all
        @stylesheet = Stylesheet.find(1)
    end

    def show
        @stylesheet = Stylesheet.find(params[:id])
        render text: @stylesheet.code, content_type: "text/css"
    end

    def edit
        @stylesheet = Stylesheet.find(params[:id])
    end

    # When you edit/update the category, update the information
    def update
        @stylesheet = Stylesheet.find(params[:id])
        if @stylesheet.update_attributes(params[:stylesheet].permit!)
            flash[:notice] = "Updated Stylesheet"
            redirect_to edit_admin_stylesheet_path
        else
            render :edit
        end
    end

    # Make sure only Administrators can access the ACP
    def authenticate_admin
        if !admin?
            flash[:notice] =  "Not an Administrator. Denied."
            redirect_to root_path
        end
    end
end