module Businesses
  class Rent < ApplicationRecord
    belongs_to :business
  end
end