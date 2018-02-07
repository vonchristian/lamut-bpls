module Monitoring
  class ClosedBusinessesController < ApplicationController
    def index
      @businesses = Business.closed
    end
  end
end
