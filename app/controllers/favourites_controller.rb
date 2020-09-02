class FavouritesController < ApplicationController
  before_action :set_favourite, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :authenticate_user!
 

  def show
  end
 
  def new
    @favourite = Favourite.new
  end
 
  def edit
  end

 
  def create


    @favourite = Favourite.new
    @favourite.user_id = current_user.id
    @favourite.host_id = @user.id
    @favourite.save

    respond_to do |format|
      format.js #{render inline: "location.reload();" }
    end
  end
 
  def update
    respond_to do |format|
      if @favourite.update(favourite_params)
        format.html { redirect_to @favourite.user, notice: 'favourite was successfully updated.' }
        format.json { render :show, status: :ok, location: @favourite }
      else
        format.html { render :edit }
        format.json { render json: @favourite.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @favourite.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
     
    def set_favourite
      @favourite = Favourite.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id]) 
    end

   
    def favourite_params
      params.require(:favourite).permit(:host_id, :user_id)
    end
end
