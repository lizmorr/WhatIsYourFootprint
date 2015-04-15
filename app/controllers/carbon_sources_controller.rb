class CarbonSourcesController < ApplicationController
  def index
    @carbon_sources = CarbonSource.all
  end

  def show
    @carbon_source = CarbonSource.find(params[:id])
  end
end
