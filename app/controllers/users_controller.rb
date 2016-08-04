class UsersController < ApplicationController
  before_action :check_signin, only: [:create, :new]
  before_action :check_signedin, only: [:show]

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] ||= []
      flash[:errors] += @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to :root
    elsif current_user.id == @user.id
      render :show
    else
      redirect_to :root
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
