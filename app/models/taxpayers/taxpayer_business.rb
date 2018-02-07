module Taxpayers
  class TaxpayerBusiness < ApplicationRecord
    belongs_to :business
    belongs_to :taxpayer
  end
end
