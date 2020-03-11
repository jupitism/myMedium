class StoriesController < ApplicationController 
  before_action :authenticate_user!
  before_action :find_story, only: [:edit, :update, :destroy]

  def create
    @story = current_user.stories.new(story_params)
    @story.publish! if params[:publish]
    if @story.save
      if @story.published?
        redirect_to stories_path, notice: '文章發佈成功'
      else
        redirect_to edit_story_path(@story), notice: '草稿儲存成功'
      end
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
    # @story.publish! if params[:publish]
    if @story.update(story_params)
      if @story.published?
        case
        when params[:save_as_draft]
          redirect_to stories_path, notice: '文章更新成功'
        else
          @story.unpublish!
          redirect_to stories_path, notice: '文章已下架'
        end
      else
        case
        when params[:save_as_draft]
          redirect_to edit_story_path(@story), notice: '草稿已儲存'
        else
          @story.publish!
          redirect_to stories_path, notice: '文章已發佈'
        end
      end
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

  def published_or_draft
    if @story.published?
      redirect_to stories_path, notice: '成功發佈文章'
    else
      redirect_to edit_story_path(@story), notice: '已儲存草稿'
    end
  end

  private
  
  def find_story
    @story = current_user.stories.friendly.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:title, :content, :cover_image)
  end

end
