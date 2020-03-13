class Api::StoriesController < Api::BaseController
  
  def clap
    if user_signed_in?
      story = Story.friendly.find(params[:id])
      story.increment!(:clap)
      render json: {status: story.clap}
    end
  end

end
