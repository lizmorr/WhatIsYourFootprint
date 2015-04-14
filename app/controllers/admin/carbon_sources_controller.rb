module Admin
  class CarbonSourcesController < ApplicationController
    def index
      if current_user.try(:admin?)
        @carbon_sources = CarbonSource.all
        @carbon_source = CarbonSource.new
      else
        redirect_to root_path,
          notice: "You are not authorized to access this page! Sorry'"
      end
    end

    def create
      @carbon_source = CarbonSource.new(carbon_source_params)
      if @carbon_source.save
        redirect_to admin_carbon_sources_path,
          notice: "#{@carbon_source.source} added as carbon source"
      else
        @errors = @carbon_source.errors.full_messages
        render :index
      end
    end

    def edit
      @carbon_source = CarbonSource.find(params[:id])
    end

    def update
      @carbon_source = CarbonSource.find(params[:id])
      if @carbon_source.update(carbon_source_params)
        redirect_to admin_carbon_sources_path,
          notice: "#{@carbon_source.source} updated!"
      else
        @errors = @carbon_source.errors.full_messages
        render :edit
      end
    end

    protected

    def carbon_source_params
      params.require(:carbon_source).permit(:source, :conversion_factor,
        :conversion_units, :category, :subcategory)
    end
  end
end
