class UserInfoController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_user,   only: [:show, :edit, :update]


  def profile
    @user = current_user
  end


  ## before filters
  # def correct_user
  #   if current_user.id != params[:id]
  #     render :nothing => true, :status => 403
  #   end
  # end

  private

end
