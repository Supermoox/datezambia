class UsersController < ApplicationController
  before_action :set_user, only: [:show, :photo, :add_favourite]
  before_action :authenticate_user!, only: [:show]


  def index
    @users = User.all.order("created_at DESC")
  end
  def show

    if user_signed_in?
      unless @user == current_user

        @visits = Visit.where(user_id: current_user.id).where(host_id: @user.id)        
        if @visits.blank?

          @visit = Visit.new
          @visit.user_id = current_user.id
          #@visit.visitor_id = current_user.id
          @visit.host_id = @user.id
          @user.update(new_visitors: @user.new_visitors + 1)
          @visit.save
        else
          @visits.last.update(created_at: DateTime.now)
          @user.update(new_visitors: @user.new_visitors + 1)
        end
      end

      @favourite = Favourite.new
      @favourited = Favourite.where(host_id: @user.id).where(user_id: current_user.id).last
      session[:conversations] ||= []
      @conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))
      @conversations.each do |conversation|
        session[:conversations].delete(conversation.id)
      end
      @conversations = @conversations.includes(:recipient, :messages).find(session[:conversations])
    end


    @users = User.all
    @search = Search.new
    @picture = Picture.new
    @comment = Comment.new
    @pictures = Picture.where(user_id: @user.id)
    @profile_picture = @pictures.where(profile_pic: true).last
    @profile_picture_alt = @pictures.last
    @pictures = @pictures.order("profile_pic")
    @age =  ((Time.zone.now - @user.dob.to_time) / 1.year.seconds).floor
    @total_pics = @pictures.count
    @counter = 1
    @counter2 = 1
    @counter3 = 1
    @counter4 = 1
    @count = @picture.get_upvotes.size
    @all_visits = Visit.where(host_id: @user.id)
    if @user.last_seen_at > 5.minutes.ago 
      @online = true
    end

  end

  def add_favourite
    @favourited = Favourite.where(host_id: @user.id).where(user_id: current_user.id).last

    if @favourited.blank?
      @favourite = Favourite.new
      @favourite.user_id = current_user.id
      @favourite.host_id = @user.id
      @favourite.save
      respond_to do |format|
        format.js
      end
    else 
      @favourited.destroy
    end
  end


  private
    def set_user
      @user = User.find(params[:id])
    end
end  