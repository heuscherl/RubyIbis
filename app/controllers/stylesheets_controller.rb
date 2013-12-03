class Admin::StylesheetsController < ApplicationController
	#caches_page :show # magic happens here
  respond_to :css

	def index
    	@stylesheets = Stylesheet.all
  	end
  def show
      @stylesheet = Stylesheet.find(params[:id])
      render text: @stylesheet.code, content_type: "text/css"
      # respond_to do |format|
      #   #
     #    format.html # regular ERB template
      #   format.css { render :text => @stylesheet.code, :content_type => "text/css" }
      #end
  end

  def edit
    @stylesheet = Stylesheet.find(params[:id])
  end

  	# When you edit/update the category, update the information
    def update
        @stylesheet = Stylesheet.find(params[:id])
        if @stylesheet.update_attributes(params[:stylesheet].permit!)
            redirect_to edit_stylesheet_path
        else
            render :edit
        end
    end
end
