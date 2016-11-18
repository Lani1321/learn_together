class UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @user }
    end
  end


end

