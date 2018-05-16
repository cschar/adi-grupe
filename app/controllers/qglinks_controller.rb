class QglinksController < ApplicationController
  before_action :set_grupe
  before_action :set_qglink, only: [:destroy]
  before_action :authenticate_user!

  @@quests_per_grupe = 3

  def create

    if current_user.id == @grupe.creator_id &&
       @grupe.qglinks.count < @@quests_per_grupe

      quest = Quest.find(params[:quest_id ])
      # disable ability for user to add extra 'subject' / comment info on link for now..
      # Qglink.create quest: q1, grupe: grupe2, subject: params[:comments]
      Qglink.create quest: quest, grupe: @grupe, subject: ''

      grupe.location.recent_quest_id = quest.id
      grupe.location.save
      
      redirect_to grupe_path(@grupe), notice: 'Quest added '
    else
      redirect_to @grupe, notice: 'Grupe Quest Create error'
    end

  end

  def destroy
    if current_user.id == @qglink.grupe.creator_id
      @qglink.destroy
      redirect_to @grupe, notice: 'Quest was successfully destroyed.'
    else
      redirect_to @grupe, notice: 'Cant create quests for that grupe, you didnt create it!'
    end
  end


  private

  def set_grupe
    #params grupe_id available  because we are in a __scoped route__ !!!
    @grupe = current_user.grupes.find(params[:grupe_id])
  end

  def set_qglink
    @qglink = Qglink.find(params[:id])
  end
end