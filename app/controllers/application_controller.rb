class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller? 
  before_action :set_last_seent_at, if: :user_signed_in?
  before_action :set_online_users
  before_action :set_unread,  if: :user_signed_in?
  before_action :set_notifications,  if: :user_signed_in?


 	protected

	def configure_permitted_parameters 
		devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :new_visitors, :interested_men, :interested_women, :sex, :city_id, :dob, :height, :weight, :education, :accommodation, :reason_friendship, :reason_penpal, :reason_marriage, :reason_romance, :reason_travel, :income, :email, :password, :password_confirmation, :remember_me) } 
		devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) } 
		devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :new_visitors, :interested_men, :interested_women, :sex, :city_id, :dob, :height, :weight, :education, :accommodation, :about_me, :reason_friendship, :reason_penpal, :reason_marriage, :reason_romance, :reason_travel, :income, :habit_smoking, :habit_drinking, :children, :children_num, :property_car, :property_house, :property_flat, :pet_dog, :pet_bird, :pet_cat, :pet_rabit, :religion, :tribe, :email, :password, :password_confirmation, :current_password) } 
	end 


	def set_last_seent_at
		current_user.touch(:last_seen_at)
	end

	def set_online_users
		@online_users = User.online 
		@users = User.all
	end
	def set_notifications
		@picture_notifications = Picture.where(user_id: current_user.id).where("new_coments > ? ", 0)
		@favourites_count = Favourite.where(user_id: current_user.id).count
		@visitors_count = Visit.where(host_id: current_user.id).count
	end

	def set_unread
		@unread_msg = 0
		@conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))

		@conversations.each do |conversation|
			conversation.messages.each do |message|
				if message.user != current_user && !message.read
					@unread_msg = @unread_msg + 1
				end 
			end
		end
	end
	 
end
