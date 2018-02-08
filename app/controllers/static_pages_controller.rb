class StaticPagesController < ApplicationController
  before_action(:authenticate_user!,  only: :readquest)

  layout :layout_by_resource

  #TODO make a proper settings controller and take out of static_pages
  def layout_by_resource
    if action_name == "settings_weird"
      "application_settings"
    else
      "application"
    end
  end

  def index

  end

  def readquest
    @books = Book.all
  end

  def pricing

  end

  def feature1

  end

  def settings_weird

  end
end
