class StaticPagesController < ApplicationController
  def home
    @user = User.all
  end
end
