class TaxpayerSpecialPermit < ApplicationRecord
  belongs_to :special_permit
  belongs_to :taxpayer
  delegate :full_name, to: :taxpayer, allow_nil: true, prefix: true
  delegate :name, to: :special_permit, allow_nil: true
  def assessed?
    assessment_details_for_current_year.present?
  end
  def paid?
    payment_details_for_current_year.present?
  end
  def assessment_details_for_current_year
    entry = Accounting::Entry.assessment.where(commercial_document: self).last
		entry.present? && entry.entry_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
    entry
  end

  def payment_details_for_current_year
    entry = Accounting::Entry.payment.where(commercial_document: self).last
		entry.present? && entry.entry_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
    entry
  end
  def taxpayers_full_name
    taxpayer.full_name
  end
  def total_fees
    if special_permit.flat_rate?
      special_permit.flat_rate
    elsif special_permit.per_day?
      special_permit.rate * number_of_days
    end
  end
end
