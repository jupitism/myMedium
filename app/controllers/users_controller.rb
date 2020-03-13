class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token, only:[:follow]
	before_action :find_user
	
	def follow
		if user_signed_in?
			render json: {status: current_user.follow!(@user) }
		else
			render json: {status: 'sign_in_first' }
		end
	end
	
	private
	def find_user
		@user = User.find(params[:id])
	end
end
