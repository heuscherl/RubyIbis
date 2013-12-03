module SessionsHelper

  # Sign in. 
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  # Is the user signed in?
  def signed_in?
    !current_user.nil?
  end

  # Is the user an admin? They also have to be signed in
  def admin?  
    if signed_in? and current_user.usergroup == 2 
      return true  
    else  
      return false  
    end  
  end  

  # Remove cookies and tokens when signing out
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # if you are logged in, you are the current user.
  def current_user=(user)
    @current_user = user
  end

  # Determines the current user. 
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

end




  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
