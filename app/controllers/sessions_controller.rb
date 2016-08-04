class SessionsController < ApplicationController
  before_action :check_signin, only: [:new, :create]
  before_action :check_signedin, only: [:destroy]

  def create
    @user = User.find_by_credentials(session_params[:email], session_params[:password])
    if @user.nil?
      flash[:errors] ||= []
      flash[:errors] << "Could not verify username and/or password"
      redirect_to new_session_url
    else
      login(@user)
      redirect_to user_url(@user)
    end
  end

  def new
    @user = User.new
  end

  def destroy
    logout
    redirect_to :root
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end

end
