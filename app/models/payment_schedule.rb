class PaymentSchedule < ApplicationRecord
  belongs_to :business
  def self.for_current_year
    all.select{ |a| a.payment_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }
  end
  def self.set(business)
    if business.semi_annually?
      business.payment_schedules.create(payment_date: Time.zone.now.beginning_of_year.next_quarter.end_of_quarter, amount: (business.total_taxes / 2))
      business.payment_schedules.create(payment_date: Time.zone.now.end_of_year, amount: (business.total_taxes / 2))
    elsif business.quarterly?
      business.payment_schedules.create(payment_date: Time.zone.now.beginning_of_year.end_of_quarter, amount: (business.total_taxes / 4) )
      business.payment_schedules.create(payment_date: Time.zone.now.beginning_of_year.next_quarter.end_of_quarter, amount: (business.total_taxes / 4))
      business.payment_schedules.create(payment_date: Time.zone.now.beginning_of_year.next_quarter.next_quarter.end_of_quarter, amount: (business.total_taxes / 4))
      business.payment_schedules.create(payment_date: Time.zone.now.end_of_year, amount: (business.total_taxes / 4))
    end
  end
end
