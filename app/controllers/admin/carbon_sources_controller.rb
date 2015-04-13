module Admin
  class CarbonSourcesController < ApplicationController
    def index
      @carbon_source = CarbonSource.new
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

    protected

    def carbon_source_params
      params.require(:carbon_source).permit(:source, :conversion_factor,
        :conversion_units, :category, :subcategory)
    end
  end
end
