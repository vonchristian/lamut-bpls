module Accounting
  class Account < ActiveRecord::Base

    REGULATORY_ACCOUNTS = ["Building Permit Fees",
    "Zonal/Location Permit Fees",
    "Health Certificate Fees",
    "Police Clearance Fees",
    "Sanitary Inspection Fees",
    "Storage Permit Fees",
    "Annual Inspection Fees",
    "Occupancy Permit Fees"]

    ACCOUNTS_RECEIVABLES = ["Accounts Receivable - Business Tax",
      "Accounts Receivable - Capital Tax",
      "Accounts Receivable - Building Permit Fees",
      "Accounts Receivable - Zonal/Location Permit Fees",
      "Accounts Receivable - Business TIN Plate Fees",
      "Accounts Receivable - Documentary Stamp Fees",
      "Accounts Receivable - Health Certificate Fees",
      "Accounts Receivable - Police Clearance Fees",
      "Accounts Receivable - Sanitary Inspection Fees",
      "Accounts Receivable - Storage Permit Fees",
      "Accounts Receivable - Garbage Fees",
      "Accounts Receivable - Business Permit Fees",
      "Accounts Receivable - Annual Inspection Fees",
      "Accounts Receivable - Occupancy Permit Fees",
      "Accounts Receivable - Special Permit Fees",
      "Accounts Receivable - Cockpit Operation Fees",
      "Accounts Receivable - Electrical Installation Fees",
      "Accounts Receivable - Plumbing Installation Fees",
      "Accounts Receivable - Other Accessories Fees",
      "Accounts Receivable - Engineering Penalties/Surcharges",
      "Accounts Receivable - Interest Income"
      ]
    FIRE_DEPT_EXEMPTS = ["Accounts Receivable - Business Tax",
      "Accounts Receivable - Capital Tax",
      "Accounts Receivable - Business TIN Plate Fees",
      'Accounts Receivable - Sticker Fees',
      "Accounts Receivable - Documentary Stamp Fees"
      ]

    class_attribute :normal_credit_balance

    has_many :amounts, class_name: "Accounting::Amount"
    has_many :credit_amounts, :extend => AmountsExtension, :class_name => 'Accounting::CreditAmount'
    has_many :debit_amounts, :extend => AmountsExtension, :class_name => 'Accounting::DebitAmount'
    has_many :entries, through: :amounts, source: :entry
    has_many :credit_entries, :through => :credit_amounts, :source => :entry, :class_name => 'Accounting::Entry'
    has_many :debit_entries, :through => :debit_amounts, :source => :entry, :class_name => 'Accounting::Entry'

    validates_presence_of :type
    validates :name, presence: true, uniqueness: true
    def self.accounts_receivables
      select{ |a| ACCOUNTS_RECEIVABLES.include?(a.name) }
    end
    def self.regulatory_accounts
      select{ |a| REGULATORY_ACCOUNTS.include?(a.name) }
    end
    def self.active
      all.where(active: true)
    end
    def self.types
      ["Accounting::Asset",
       "Accounting::Equity",
       "Accounting::Liability",
       "Accounting::Expense",
       "Accounting::Revenue"]
    end

    def self.disabled
      all.where(enabled: false)
    end

    def balance(options={})
      if self.class == Accounting::Account
        raise(NoMethodError, "undefined method 'balance'")
      else
        if self.normal_credit_balance ^ contra
          credits_balance(options) - debits_balance(options)
        else
          debits_balance(options) - credits_balance(options)
        end
      end
    end

    def credits_balance(options={})
      credit_amounts.balance(options)
    end

    def debits_balance(options={})
      debit_amounts.balance(options)
    end

    def self.balance(options={})
      if self.new.class == Accounting::Account
        raise(NoMethodError, "undefined method 'balance'")
      else
        accounts_balance = BigDecimal.new('0')
        accounts = self.all
        accounts.each do |account|
          if account.contra
            accounts_balance -= account.balance(options)
          else
            accounts_balance += account.balance(options)
          end
        end
        accounts_balance
      end
    end

    def self.trial_balance
      if self.new.class == Accounting::Account
        Accounting::Asset.balance - (Accounting::Liability.balance + Accounting::Equity.balance + Accounting::Revenue.balance - Accounting::Expense.balance)
      else
        raise(NoMethodError, "undefined method 'trial_balance'")
      end
    end
    def disabled?
      !enabled?
    end
    def disable!
      self.enabled = false
      self.save
    end

    def enable!
      self.enabled = true
      self.save
    end
    def collection_for(hash={})
      from_date = hash[:from_date].kind_of?(Date) ? hash[:from_date] : DateTime.parse(hash[:from_date].strftime('%Y/%m/%d'))
      to_date = hash[:to_date].kind_of?(Date) ? hash[:to_date] : DateTime.parse(hash[:to_date].strftime('%Y/%m/%d'))
      debit_entries.where('entries.entry_date' => from_date..to_date).where(barangay: hash[:barangay]).distinct.sum(:amount)
    end
    def assessed_for(hash={})
      credit_entries.where(barangay: hash[:barangay]).distinct.sum(:amount)
    end
  end
end
