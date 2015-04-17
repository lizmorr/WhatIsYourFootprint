module Admin
  class CarbonSourcesController < ApplicationController
    before_action :authenticate_user_is_admin

    def index
      @carbon_sources = CarbonSource.all
      @carbon_source = CarbonSource.new
    end

    def create
      @carbon_source = CarbonSource.new(new_carbon_source_params)
      if @carbon_source.save
        redirect_to admin_carbon_sources_path,
          notice: "#{@carbon_source.source} added as carbon source"
      else
        @errors = @carbon_source.errors.full_messages
        @carbon_sources = CarbonSource.all
        render :index
      end
    end

    def edit
      @carbon_source = CarbonSource.find(params[:id])
    end

    def update
      @carbon_source = CarbonSource.find(params[:id])
      if @carbon_source.update(edit_carbon_source_params)
        redirect_to admin_carbon_sources_path,
          notice: "#{@carbon_source.source} updated!"
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
