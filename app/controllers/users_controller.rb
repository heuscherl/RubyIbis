# This allows the creation, member list and profiles
# of the forum. 

class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  #GET /users/ - views/users/index.html.erb
  # This shows the member list.
  def index
    @users = User.paginate(page:params[:page])
  end

  #GET /users/1 - views/users/show.html.erb
  def show
    @user = User.find(params[:id])
  end

  # What to show when you edit the category.
  def edit
    @user = User.find(params[:id])
  end

  #GET /users/new - views/users/new.html.erb
  def new
    @user = User.new
  end

  # POST. 
  # When you create a user, you sign in with that account.
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  # When you edit/update the category, update the information
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_edit)
      flash[:notice] = "Profile Updated."
      redirect_to @user
    else
      render :edit
    end
  end

  # Destroy/delete the Category.
  def destroy
      User.destroy(params[:id])
      redirect_to user_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

  def user_params_edit
    params.require(:user).permit(:avatar, :name, :email, :password,
                                   :password_confirmation, :birthday, :website, :biblography, :location)
  end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
