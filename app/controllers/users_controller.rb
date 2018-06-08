class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!
  before_action :correct_user,   only: [:edit, :update]


  def show

  end

  def edit

  end

  def show_profile
    redirect_to current_user
  end


  #   PATCH/PUT /quests/1
  # PATCH/PUT /quests/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)


        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def correct_user
    current_user == @user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    
    params.require(:user)
    params[:tag] = FFaker::Color.name  + FFaker::CheesyLingo.sentence.split(" ").sample
    params.permit(:tag)
    
  end

end
