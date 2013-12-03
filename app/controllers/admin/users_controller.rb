# This allows the creation, member list and profiles
# of the forum. 

class Admin::UsersController < ApplicationController
  before_filter :authenticate_admin

  #GET /users/ - views/users/index.html.erb
  # This shows the member list.
  def index
    @users = User.all
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
      redirect_to admin_users_url
    else
      render 'new'
    end
  end

  # When you edit/update the category, update the information
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_edit)
      # @user.update_attributes(
      # :name => params[:user][:name], 
      # :email => params[:user][:email], 
      # :usergroup => params[:user][:usergroup])
          redirect_to admin_users_url
      else
          render :edit
      end
  end


  # Destroy/delete the Category.
  def destroy
      User.destroy(params[:id])
      redirect_to admin_users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :usergroup)
    end

  # When editing your profile, show all this. 
  def user_params_edit
    params.require(:user).permit(:avatar, :name, :email, :password,
                                   :password_confirmation, :birthday, :website, :biblography, :location)
  end
    
    # Make sure only Administrators can access the ACP
    def authenticate_admin
        if !admin?
            flash[:notice] =  "Not an Administrator. Denied."
            redirect_to root_path
        end
    end
end