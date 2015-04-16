module Admin
  class UseReasonsController < ApplicationController
    def index
      if current_user.try(:admin?)
        @use_reasons = UseReason.all
        @use_reason = UseReason.new
      else
        redirect_to root_path,
          alert: "Sorry, you were not authorized to access that page!"
      end
    end

    def create
      @use_reason = UseReason.new(use_reason_params)
      if current_user.try(:admin?) && @use_reason.save
        redirect_to admin_carbon_sources_path,
          notice: "#{@use_reason.name} added as new use reason"
      elsif !current_user.try(:admin?)
        redirect_to root_path,
          alert: "Sorry, you were not authorized to access that action!"
      else
        @errors = @use_reason.errors.full_messages
        @use_reasons = UseReason.all
        render "admin/carbon_sources/index"
      end
    end

    def edit
      if current_user.try(:admin?)
        @use_reason = UseReason.find(params[:id])
      else
        redirect_to root_path,
          alert: "Sorry, you were not authorized to access that page!"
      end
    end

    def update
      @use_reason = UseReason.find(params[:id])
      if current_user.try(:admin?) && @use_reason.update(use_reason_params)
        redirect_to admin_carbon_sources_path,
          notice: "#{@use_reason.name} updated!"
      elsif !current_user.try(:admin?)
        redirect_to root_path,
          alert: "Sorry, you were not authorized to access that action!"
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
