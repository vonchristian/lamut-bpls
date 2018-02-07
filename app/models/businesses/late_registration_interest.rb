module Businesses
  class LateRegistrationInterest < ApplicationRecord
    belongs_to :interestable, polymorphic: true

    def self.set_interest(interestable)
      if interestable.late_registration?
        rate = BploSection::Settings::InterestRate.order(created_at: :desc).last.rate
        (interestable.total_mayors_permit_fees * rate) * self.new.number_of_months_delayed(interestable)
      end
    end

    def self.for_current_year
      interest = all.select{ |a| a.calendar_year.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }.last
      if interest.present?
        interest.amount
      else
        0
      end
    end
    def self.assessment_for(business)
      paid_amount = self.new.debit_account.credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: self.new.debit_account).pluck(:amount).sum}.sum
      business.late_registration_interests.for_current_year - paid_amount
    end
    def self.current_year
      all.find{ |a| a.current? }
    end
    def current?
      calendar_year.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
    end

    def number_of_months_delayed(interestable)
      start_date = BploSection::Settings::PermitApplicationDateRange.order(created_at: :asc).last.start_date
      end_date = interestable.latest_application_date
      number = (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
      if number.zero?
        1
      else
        number
      end
    end

    def debit_account
      Accounting::Asset.find_by(name: 'Accounts Receivable - Interest Income')
    end

    def credit_account
      Accounting::Revenue.find_by(name: 'Interest Income')
    end
  end
end
