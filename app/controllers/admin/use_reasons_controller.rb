module Admin
  class UseReasonsController < ApplicationController
    before_action :authenticate_user_is_admin

    def index
      @use_reasons = UseReason.all
      @use_reason = UseReason.new
    end

    def create
      @use_reason = UseReason.new(use_reason_params)
      if @use_reason.save
        redirect_to admin_carbon_sources_path,
          notice: "#{@use_reason.name} added as new use reason"
      else
        @errors = @use_reason.errors.full_messages
        @use_reasons = UseReason.all
        render :index
      end
    end

    def edit
      @use_reason = UseReason.find(params[:id])
    end

    def update
      @use_reason = UseReason.find(params[:id])
      if @use_reason.update(use_reason_params)
        redirect_to admin_carbon_sources_path,
          notice: "#{@use_reason.name} updated!"
      else
        @errors = @use_reason.errors.full_messages
        render :edit
      end
    end

    protected

    def use_reason_params
      params.require(:use_reason).permit(:name)
    end
  end
end
