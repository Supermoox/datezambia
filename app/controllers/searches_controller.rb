class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create 
    @search = Search.create!(search_params)

    redirect_to @search
  end

  def show
    @search2 = Search.new
    @search = Search.find(params[:id])
    @searches = @search.find_users.paginate(page: params[:page], per_page: 10)
    @users = User.all

  end

  def update
  end
  
  private
    def search_params
      params.require(:search).permit(:age, :city_id, :sex, :religion)
    end
end
