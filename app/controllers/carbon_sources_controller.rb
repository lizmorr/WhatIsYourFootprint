class CarbonSourcesController < ApplicationController
  def show
      @carbon_source = CarbonSource.find(params[:id])
  end
end
