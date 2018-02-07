module Businesses
  class GrossSale < ApplicationRecord
    MINIMUM_GROSS_SALE_FOR_RETAILERS = 30_000
    belongs_to :business
    belongs_to :business_activity, class_name: "Businesses::BusinessActivity"

    validates :amount, presence: true, numericality: { greater_than: 1 }
    validates :calendar_year, presence: true

    delegate :gross_sales_tax_business_category, to: :business
    delegate :is_retailer?, to: :business, prefix: true


    delegate :gross_sales_entered_on?, to: :business, allow_nil: true
    before_validation :set_date
    after_commit :set_tax, if: :persisted?

    def self.for(business)
      all.where(business: business)
    end
    def self.for_previous_year
      gross_sale = all.select{ |a| a.calendar_year.between?(Time.zone.now.last_year.beginning_of_year, Time.zone.now.last_year.end_of_year) }
    end
    def self.for_current_year
      for_previous_year.sum(&:amount)
    end

    def self.taxes_for_current_year
      pluck(:tax_amount).compact.sum
    end


    def self.assessment_for(business)
      paid_amount = Accounting::Account.find_by(name: "Accounts Receivable - Business Tax").credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: Accounting::Account.find_by(name: "Accounts Receivable - Business Tax")).pluck(:amount).sum}.sum
      business.gross_sales.taxes_for_current_year - paid_amount
    end

    def self.total_tax
      all.sum(:tax_amount)
    end

    private
    def set_date
      self.calendar_year ||= Time.zone.now.last_year.end_of_year
    end
    def set_tax
      BploSection::Taxes::GrossSalesTax.set_tax(self)
    end
  end
end
