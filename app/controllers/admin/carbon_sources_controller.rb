module Admin
  class CarbonSourcesController < ApplicationController
    def new
      @carbon_source = CarbonSource.new
    end
  end
end
