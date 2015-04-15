class CarbonSourcesController < ApplicationController
  def index
    @carbon_sources = CarbonSource.all
  end
end
