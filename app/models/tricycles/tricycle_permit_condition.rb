module Tricycles
  class TricyclePermitCondition < ApplicationRecord
    belongs_to :tricycle_permit_approval
    belongs_to :permit_condition
  end
end
