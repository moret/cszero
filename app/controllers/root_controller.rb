class RootController < ApplicationController
  def index
    if admin_signed_in?
      redirect_to :users
    elsif user_signed_in?
      redirect_to :cases
    end
  end
end
