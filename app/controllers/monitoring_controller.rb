class MonitoringController < ApplicationController
  def index
    @barangays = Addresses::Barangay.in_lamut
  end
end
