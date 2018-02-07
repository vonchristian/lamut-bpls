module Tricycles
  class TricycleRequirementVerification < ApplicationRecord
    belongs_to :applicable_tricycle_requirement
    belongs_to :verifier, class_name: "User", foreign_key: 'user_id'
  end
end
