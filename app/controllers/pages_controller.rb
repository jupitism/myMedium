class PagesController < ApplicationController

  def index
    @stories = Story.published.order(created_at: :desc)
  end

  def show
  end

  def user
  end

end
