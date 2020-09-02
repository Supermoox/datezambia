class PagesController < ApplicationController
  def home
    @users = User.all
    @search = Search.new
  end
  def users_online
  	@users = User.all
  	@search = Search.new
  end  
  def recently_online
  	@users = User.all
  	@recently_online = User.where("last_seen_at < ? ", 5.minutes.ago).where("last_seen_at > ? ", 60.minutes.ago)
  	@search = Search.new
  end  
  def users_offline
    @users = User.all
    @users_offline = User.where("last_seen_at < ? ", 5.minutes.ago)
    @search = Search.new
  end  
  def visitors
    @users = User.all
    @visits = Visit.where(host_id: current_user.id).order("created_at DESC")
    @search = Search.new

    current_user.update(new_visitors: 0)
  end     
  def favourites
    @users = User.all
    @favourites = Favourite.where(user_id: current_user.id).order("created_at DESC")
    @favourite_host_ids = @favourites.all.map { |favourite| favourite.host_id }
    @favourite_users = User.where(id: @favourite_host_ids)

    session[:conversations] ||= []
    @conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))

    @conversations = @conversations.includes(:recipient, :messages).find(session[:conversations])
  end 

  def blocked
    @users = User.all
    @search = Search.new
  end   

  def history
    @users = User.all
    @visits = Visit.where(user_id: current_user.id).order("created_at DESC")
    @search = Search.new

    @host_ids = @visits.all.map { |host| host.host_id }
    @host_ids = @host_ids.uniq
    @history = User.where(id: @host_ids)
  end  
  def notifications
    @counter = 1
    @counter2 = 1
    @counter3 = 1
    @counter4 = 1
    @comment = Comment.new
  	@users = User.all
  	@search = Search.new
    @pictures = Picture.where(user_id: current_user.id)
  end

end
