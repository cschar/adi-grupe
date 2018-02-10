class GrupecommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_grupe


  def create
    Grupecomment.create comment: params[:comment], grupe: @grupe, user: current_user
    # redirect_to grupe_path(@grupe)
  end

  def set_grupe
    @grupe = Grupe.find(params[:grupe_id])
  end

end