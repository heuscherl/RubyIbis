#The controller to create, destroy and edit posts. 
# Posts must be within a Topic/Thread. 

    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :edit, :update, :destroy]

      # GET /posts
      # GET /posts.json
      def index
        @posts = Post.all
      end

      # GET /posts/1
      # GET /posts/1.json
      def show
      end

      # GET /posts/new
      def new
        @post = Post.new
      end

      # GET /posts/1/edit
      def edit
        @post = Post.find(params[:id])
      end

      # POST /posts
      # POST /posts.json
    def create  
      @post = Post.new(
        :content => params[:post][:content], 
        :topic_id => params[:post][:topic_id], 
        :user_id => current_user.id)  

      if @post.save  
        @topic = Topic.find(@post.topic_id)  
        @topic.update_attributes(
          :last_poster_id => current_user.id, 
          :last_post_at => Time.now)  
        flash[:notice] = "Successfully created post."  
        redirect_to "/topics/#{@post.topic_id}"  
      else  
        render :action => 'new'  
      end  
    end  

      # PATCH/PUT /posts/1
      # PATCH/PUT /posts/1.json
    def update  
      @post = Post.find(params[:id])  
        if @post.update_attributes(params[:post].permit!) 
        @topic = Topic.find(@post.topic_id)  
        @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)  
        flash[:notice] = "Successfully updated post."  
        redirect_to "/topics/#{@post.topic_id}"   
      else  
        render :action => 'edit'  
      end  
    end  

      # DELETE /posts/1
      # DELETE /posts/1.json
    def destroy
      @post = Post.find(params[:id])
      @topic = @post.topic
      @post.destroy
      last_post = @topic.reload.posts.last
      @topic.update_attributes(last_poster_id: last_post.user_id, last_post_at: last_post.created_at)
      redirect_to @topic
    end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_post
          @post = Post.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def post_params
          params.require(:topic).permit(:content, :topic_id, :user_id)
        end
    end
