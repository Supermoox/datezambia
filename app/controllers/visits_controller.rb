class VisitsController < ApplicationController

  def new
    @visit = Visit.new
  end

  
  def edit
  end

  def show
    
  end

 
  def create
    @visit = Visit.new(visit_params)

    respond_to do |format|
      if @visit.save
        format.html { redirect_to root_path, notice: 'visit was successfully created.' }
        format.json { render :show, status: :created, location: root_path }
      else
        format.html { render :new }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @visit.update(visit_params)
  end

 
  def destroy
    @visit.destroy
    redirect_to root_path
  end

  private

    def set_visit
      @visit = Visit.find(params[:id])
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end

    def visit_params
      params.require(:visit).permit(:visit_id, :host_id)
    end

end

