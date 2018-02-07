module Tricycles
  class TricyclePermitApproval < ApplicationRecord
    belongs_to :tricycle_permit_application
    belongs_to :tricycle
    has_many :conditions, class_name: "Tricycles::TricyclePermitCondition", dependent: :destroy
    has_many :permit_conditions, through: :conditions
    validates :permit_number, presence: true
    before_save :set_default_date
    delegate :transaction_type, :expired?, to: :tricycle_permit_application, allow_nil: true
    delegate :name, :ownership_type_name, :full_address, :taxpayers_full_name, to: :tricycle, prefix: true, allow_nil: true
    delegate :taxpayers_full_name, to: :tricycle, prefix: true, allow_nil: true

    after_save :set_default_conditions

    private
    def set_default_date
      self.date_approved ||= Time.zone.now
    end
    def set_default_conditions
      PermitCondition.set_default(self)
    end
  end
end
