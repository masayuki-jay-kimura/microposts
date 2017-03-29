class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :following, :destroy]
  before_action :user_confirm, only: [:edit, :following, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to @user
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def following
    @user = User.find(params[:id]) 
    @users = @user.following_users
  end

  private
  
  def user_confirm
    @user = User.find(params[:id]) 
    unless @user == current_user
      redirect_to(root_url)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :location)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
