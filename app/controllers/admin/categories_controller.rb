# This file is the controls of the categories. 
# Allows you to create, destroy and edit categories. 

class Admin::CategoriesController < ApplicationController
  before_filter :authenticate_admin

  # GET function. view/categories/index.html.erb
  def index
    @categories = Category.all
  end

  # GET /categories/1. view/categories/show.html.erb
  def show
    @category = Category.find(params[:id])
  end

  # GET /categories/new. view/categories/new.html.erb
  # Be able to list all the Categories. 
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  # Be able to list all the categories. 
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # Allows the creation of a new forum
def create  
    @category = Category.new(cat_params) 

  if @category.save  
    redirect_to admin_categories_url
  else  
    render :action => 'new'  
  end  
end 

  # PATCH/PUT /categories/1
  # Allows the update of categories.
  def update
        @category = Category.find(params[:id])
    if @category.update(cat_params)
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
      Category.destroy(params[:id])
      redirect_to admin_categories_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cat
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cat_params
      params.require(:category).permit(:id, :name)
    end

    # Make sure only Administrators can access the ACP
    def authenticate_admin
        if !admin?
            flash[:notice] =  "Not an Administrator. Denied."
            redirect_to root_path
        end
    end
end
