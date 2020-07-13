class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @beads = @user.beads
  end
end