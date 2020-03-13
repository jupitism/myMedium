class Api::UsersController < Api::BaseController

	before_action :find_user
	
	def follow
		if user_signed_in?
			render json: {status: current_user.follow!(@user) }
		end
	end
	
	private
	
	def find_user
		@user = User.find(params[:id])
	end

end
