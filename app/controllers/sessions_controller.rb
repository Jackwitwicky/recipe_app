class SessionsController < ApplicationController
  def new
    session[:previous_recipe_page] = request.env['HTTP_REFERER']
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      log_in(user)
      remember(user)
      flash[:success] = "You have been logged in"
      redirect_to session[:previous_recipe_page]
    else
      flash[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Logout was successful"
    redirect_to root_path
  end
end
