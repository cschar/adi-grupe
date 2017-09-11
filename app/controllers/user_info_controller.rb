class UserInfoController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_user,   only: [:show, :edit, :update]

  # GET /user/info.json
  def show

    respond_to do |format|
      format.json { render json: current_user}
    end
  end


  ## before filters
  # def correct_user
  #   if current_user.id != params[:id]
  #     render :nothing => true, :status => 403
  #   end
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_user
  #   @lmarker = Lmarker.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user_info).permit(:points)
  end

end
