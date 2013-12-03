class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user, :except => [:show]

  def authenticate_user
    if !signed_in?
        flash.alert = "Not signed in. Denied."
        redirect_to root_url
    end
  end

  # GET /topics
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  def show
    @topic = Topic.find(params[:id])
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    @topic.posts.build


  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create  
    #render text: topic_params and return
    @topic = Topic.new(topic_params)


    if @topic.save 
      @topic = Topic.find(@topic.id)
      @topic.update_attributes(
        :last_poster_id => current_user.id, 
        :last_post_at => Time.now,
        :user_id => current_user.id)

        flash[:success] = "Topic Posted"
        redirect_to "/forums/#{@topic.forum_id}" 
    else  
      render :new  
    end   
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    if @topic.update(topic_params)
      redirect_to "/forums/#{@topic.forum_id}" 
    else
      render :edit
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
      redirect_to "/forums/#{@topic.forum_id}" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      # last_post_at = (:last_post_at => Time.now)
      params.require(:topic).permit(
        :name, 
        :description, 
        [:last_poster_id => current_user.id], 
        [:last_post_at => Time.now], 
        [:user_id => current_user.id],
        :forum_id,
        posts_attributes: [:id, :content, :topic_id, :user_id] )
    end
end
