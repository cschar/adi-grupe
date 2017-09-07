class ArvenController < ApplicationController
  before_action(:authenticate_user!,  only: :index)

  def index
    @pods = [{:time => 23},
               {:time => 30},
               {:time => 31}]

    @markers = Marker.all


    if Rails.env.production?
      protocol_and_host = request.protocol + request.host
    else
      protocol_and_host = request.protocol + request.host_with_port
    end

    gon.push({:user_id => current_user.id,
               :protocol_and_host => protocol_and_host})

  end
end
