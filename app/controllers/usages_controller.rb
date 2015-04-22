class UsagesController < ApplicationController
  before_action :authenticate_user

  def index
    respond_to do |format|
      format.html {
        @usages = Usage.user_usage(current_user).page(params[:page])
        @total_emissions = Usage.user_total_emissions(current_user)
        render :index
      }
      format.json {
        render json: Usage.daily_emissions_summary(current_user, 30.days.ago, Date.today).to_json
      }
    end
  end

  def new
    @usage = Usage.new
  end

  def create
    @usage = Usage.new(usage_params)
    @usage.user = current_user
    if @usage.save
      flash[:notice] = "New personal usage added"
      redirect_to usages_path
    else
      @errors = @usage.errors.full_messages
      render :new
    end
  end

  def edit
    @usage = Usage.find(params[:id])
  end

  def update
    @usage = Usage.find(params[:id])
    if @usage.changeable_by?(current_user) && @usage.update(usage_params)
      redirect_to usages_path,
        notice: "Usage updated!"
    else
      @errors = @usage.errors.full_messages
      render :edit
    end
  end

  def destroy
    @usage = Usage.find(params[:id])
    if @usage.changeable_by?(current_user)
      @usage.destroy
      flash[:notice] = "Usage deleted"
      redirect_to usages_path
    end
  end

  protected

  def usage_params
    params.require(:usage).permit(:carbon_source_id, :amount_used, :units,
      :start_date, :end_date, :notes, :use_reason_id)
  end
end
