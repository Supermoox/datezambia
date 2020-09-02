class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :vote, :make_profile_pic, :destroy, :reset]
  before_action :set_user, except: [:destroy, :show, :vote,:make_profile_pic, :reset]
  before_action :authenticate_user!, except: [:show, :index]
  respond_to :js, :json, :html

  def index
    @users = User.all
    @search = Search.new
    @picture = Picture.new
    @comment = Comment.new
    @favourite = Favourite.new
    @pictures = Picture.where(user_id: @user.id)
    @profile_picture = @pictures.where(profile_pic: true).last
    @profile_picture_alt = @pictures.last
    @total_pics = @pictures.count
    @pictures = @pictures.order("profile_pic")    
    @favourited = Favourite.where(host_id: @user.id).where(user_id: current_user.id).last
    @counter = 1
    @counter2 = 1
    @counter3 = 1
    @counter4 = 1
    @count = @picture.get_upvotes.size
    session[:conversations] ||= []
    @conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))
    @conversations.each do |conversation|
      session[:conversations].delete(conversation.id)
    end

    @conversations = @conversations.includes(:recipient, :messages).find(session[:conversations])
    if @user.last_seen_at > 5.minutes.ago 
      @online = true
    end
  end

  def reset
    @picture.update(new_coments: 0)    
    @picture.update(new_likes: 0)    
  end

  def show
  end

  def new
    @picture = Picture.new
  end

  def edit
  end


  def create
    @picture = Picture.new(picture_params)

    @picture.user_id = current_user.id
    @picture.profile_pic = false

    if @picture.save
      redirect_to user_pictures_path(@user)
    else
      render 'new'
    end
  end


  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def make_profile_pic
    @pictures = Picture.where(user_id: @picture.user_id)
    @pictures.each do |pic|
      if pic.profile_pic?
        pic.update(profile_pic: false)
      end
    end
    @picture.update(profile_pic: true)
    redirect_to @picture.user
    flash[:notice] = "profile picture changed!"
  end
  def vote
    if !current_user.liked? @picture
      @picture.liked_by current_user
    elsif current_user.liked? @picture
      @picture.unliked_by current_user
    end 
  end

  def destroy
    @user = @picture.user
    @picture.destroy
    flash[:notice] = "photo deleted "
    redirect_to user_pictures_path(@user)
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end    
    def set_user
      @user = User.find(params[:user_id])
    end

    def picture_params
      params.require(:picture).permit(:profile_pic, :new_likes ,:new_comments, :image)
    end
end
