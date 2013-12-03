# This is the control to edit forums. 
# Allows the creation, deletion and edits to the forum. 
# Also allows you to assign a forum to a category. 

class ForumsController < ApplicationController
  before_action :set_forum, only: [:show, :edit, :update, :destroy]

  # GET function. view/forums/index.html.erb
  def index
    @forums = Forum.all
  end

  # GET /forums/1. view/forums/show.html.erb
  def show
    @forum = Forum.find(params[:id])
  end

  # GET /forums/new. view/forums/new.html.erb
  # Be able to list all the Categories. 
  def new
    @forum = Forum.new
    @categories = Category.all

  end

  # GET /forums/1/edit
  # Be able to list all the categories. 
  def edit
    @forum = Forum.find(params[:id])
    @categories = Category.all
  end

  # POST /forums
  # Allows the creation of a new forum
  def create
    @forum = Forum.new(forum_params)
    
    if @forum.save
      @forum = Forum.new(:name => params[:forum][:name], 
      :category_id => params[:forum][:category_id])  
      redirect_to categories_url
    else
      render :new
    end
  end

  # PATCH/PUT /forums/1
  # Allows the update of forums.
  def update
    if @forum.update(forum_params)
      redirect_to categories_url
    else
      render :edit
    end
  end

  # DELETE /forums/1
  def destroy
    @forum.destroy
    respond_to do |format|
      format.html { redirect_to forums_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum
      @forum = Forum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forum_params
      params.require(:forum).permit(:name, :description, :category_id)
    end
end
