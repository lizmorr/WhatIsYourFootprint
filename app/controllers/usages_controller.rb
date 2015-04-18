class UsagesController < ApplicationController
  before_action :authenticate_user

  def index
    @usages = Usage.where(user: current_user)
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
    if @usage.update(usage_params)
      redirect_to usages_path,
        notice: "Usage updated!"
    else
      @errors = @usage.errors.full_messages
      render :edit
    end
  end

  protected

  def usage_params
    params.require(:usage).permit(:carbon_source_id, :amount_used, :units,
      :start_date, :end_date, :notes, :use_reason_id)
  end
end
