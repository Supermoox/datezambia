class CitiesController < ApplicationController
  before_action :set_city, only: [:edit, :update]

  def new
  	@city = City.new
  end

  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to new_city_path, notice: 'City was successfully created.' }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to new_city_path, notice: 'City was successfully  updated.' }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    def city_params
      params.require(:city).permit(:name, :google_map)
    end


    def set_city
      @city = City.find(params[:id])
    end
end
