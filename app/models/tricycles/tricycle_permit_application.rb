module Tricycles
  class TricyclePermitApplication < ApplicationRecord
    enum transaction_type: [:new_application, :renew]
    belongs_to :tricycle, touch: true
    has_one :tricycle_permit_approval, class_name: "Tricycles::TricyclePermitApproval"
    validates :application_date, :application_number, presence: true
    def self.for_current_year
      all.select {|a| a.application_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)}.last
    end
    def approved?
      tricycle_permit_approval.present?
    end
    def expired?
      tricycle_permit_approval.date_approved > Time.zone.now
    end
  end
end
