module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  #remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #returns the current user
  def current_user
    if session[:user_id]
      if @current_user
        @current_user
      else
        @current_user = User.find_by(id: session[:user_id])
        return @current_user
      end
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    if current_user
      true
    else
      false
    end
  end

  def admin_logged_in?
    if current_user == User.find_by(email: "admin@root.com")
      true
    else
      false
    end
  end

  #forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
