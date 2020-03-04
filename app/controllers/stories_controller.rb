class StoriesController < ApplicationController 
  before_action :authenticate_user!
  before_action :find_story, only: [:edit, :update, :destroy]

  def create
    @story = current_user.stories.new(story_params)
    @story.status = 'published' if params[:publish]
    
    if @story.save
      published_or_draft
    else
      render :new
    end
  end

  def index
    @stories = current_user.stories.order(created_at: :desc)
  end

  def edit
  end

  def update
    @story.status = 'published' if params[:publish]

    if @story.update(story_params) 
      published_or_draft
    else
     render :edit
    end
  end

  def destroy
    @story.destroy
    redirect_to stories_path, notice: '文章已刪除'
  end
  
  def new
    @story = current_user.stories.new
  end

  private
    def find_story
      @story = current_user.stories.find(params[:id])
    end

    def story_params
      params.require(:story).permit(:title, :content)
    end

    def published_or_draft
      if params[:publish]
        redirect_to stories_path, notice: '成功發佈文章'
      else
        redirect_to edit_story_path(@story), notice: '已儲存草稿'
      end
    end
end
