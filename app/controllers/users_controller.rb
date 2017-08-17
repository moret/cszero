class UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @report = Case.report
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

private

  def user_params
    params.require(:user).permit :email, :password
  end
end
