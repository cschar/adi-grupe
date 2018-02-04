class StaticPagesController < ApplicationController
  before_action(:authenticate_user!,  only: :readquest)

  def index

  end

  def readquest
    @books = Book.all
  end

  def pricing

  end

  def feature1

  end
end
