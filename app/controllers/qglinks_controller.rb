class QglinksController < ApplicationController
  before_action :set_grupe
  before_action :authenticate_user!


  def create


      quest = Quest.find(params[:quest_id ])
      # disable ability for user to add extra 'subject' / comment info on link for now..
      # Qglink.create quest: q1, grupe: grupe2, subject: params[:comments]
      Qglink.create quest: quest, grupe: @grupe, subject: ''

      redirect_to grupe_path(@grupe)
  end


  private

  def set_grupe
    #params grupe_id available  because we are in a __scoped route__ !!!
    @grupe = current_user.grupes.find(params[:grupe_id])
  end
end