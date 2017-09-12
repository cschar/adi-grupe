class StaticPagesController < ApplicationController
  before_action(:authenticate_user!,  only: :inven)

  def index

  end

end
