module Admin
  class CarbonSourcesController < ApplicationController
    def index
      if current_user.try(:admin?)
        @carbon_sources = CarbonSource.all
        @carbon_source = CarbonSource.new
        @use_reasons = UseReason.all
        @use_reason = UseReason.new
      else
        redirect_to root_path,
          alert: "Sorry, you were not authorized to access that page!"
      end
    end

    def create
      @carbon_source = CarbonSource.new(new_carbon_source_params)
      if current_user.try(:admin?) && @carbon_source.save
        redirect_to admin_carbon_sources_path,
          notice: "#{@carbon_source.source} added as carbon source"
      elsif !current_user.try(:admin?)
        redirect_to root_path,
          alert: "Sorry, you were not authorized to access that action!"
      else
        @errors = @carbon_source.errors.full_messages
        @use_reason = UseReason.new
        @use_reasons = UseReason.all
        render :index
      end
    end

    def edit
      if current_user.try(:admin?)
        @carbon_source = CarbonSource.find(params[:id])
      else
        redirect_to root_path,
          alert: "Sorry, you were not authorized to access that page!"
      end
    end

    def update
      @carbon_source = CarbonSource.find(params[:id])
      if current_user.try(:admin?) &&
          @carbon_source.update(edit_carbon_source_params)
        redirect_to admin_carbon_sources_path,
          notice: "#{@carbon_source.source} updated!"
      elsif !current_user.try(:admin?)
        redirect_to root_path,
          alert: "Sorry, you were not authorized to access that action!"
      else
        @errors = @carbon_source.errors.full_messages
        render :edit
      end
    end

    protected

    def new_carbon_source_params
      params.require(:carbon_source).permit(:source, :conversion_factor,
        :conversion_units, :category, :subcategory)
    end

    def edit_carbon_source_params
      params.require(:carbon_source).permit(:conversion_factor,
        :conversion_units, :category, :subcategory)
    end
  end
end
