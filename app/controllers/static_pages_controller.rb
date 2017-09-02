class StaticPagesController < ApplicationController
  before_action(:authenticate_user!,  only: :inven)

  def index

  end

  def inven
      @pods = [{:time => 23},
               {:time => 30},
               {:time => 31}]
  end
end
