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

  def settings_weird_post
      

      current_user.settings[:weekly_email] = params[:weekly_email] == 'true'
      
      # replace with some params permit magic
      if params[:start_location] == "o"
        current_user.start_location = "o"
      elsif params[:start_location] == "m"
        current_user.start_location = "m"
      end
      current_user.save

      redirect_to settings_weird_path
  end


end
