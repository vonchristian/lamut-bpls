module Accounting
  class Entry < ActiveRecord::Base
    include PublicActivity::Common
    include PgSearch
    pg_search_scope :text_search, :against => [:reference_number, :description]
    enum transaction_type: [:assessment, :payment]
    before_save :default_date
    belongs_to :commercial_document, :polymorphic => true
    belongs_to :barangay, class_name: "Addresses::Barangay"
    belongs_to :recorder, class_name: "User", foreign_key: 'user_id'
    has_one :fire_dept_collection, dependent: :destroy
    has_many :credit_amounts, :extend => AmountsExtension, :class_name => 'Accounting::CreditAmount', :inverse_of => :entry, dependent: :destroy
    has_many :debit_amounts, :extend => AmountsExtension, :class_name => 'Accounting::DebitAmount', :inverse_of => :entry, dependent: :destroy
    has_many :credit_accounts, :through => :credit_amounts, :source => :account, :class_name => 'Accounting::Account'
    has_many :debit_accounts, :through => :debit_amounts, :source => :account, :class_name => 'Accounting::Account'

    validates :description, presence: true
    validate :has_credit_amounts?
    validate :has_debit_amounts?
    validate :amounts_cancel?

    # Support construction using 'credits' and 'debits' keys
    accepts_nested_attributes_for :credit_amounts, :debit_amounts, allow_destroy: true
    alias_method :credits=, :credit_amounts_attributes=
    alias_method :debits=, :debit_amounts_attributes=
    # attr_accessible :credits, :debits

    # Support the deprecated .build method
    def collected_by_fire_dept?
      fire_dept_collection.present?
    end

    def self.build(hash)
      ActiveSupport::Deprecation.warn('Accounting::Transaction.build() is deprecated (use new instead)', caller)
      new(hash)
    end

    def initialize(*args)
      super
    end
    def self.total(hash={})
      if hash[:from_date] && hash[:to_date]
        from_date = hash[:from_date].kind_of?(DateTime) ? hash[:from_date] : DateTime.parse(hash[:from_date])
        to_date = hash[:to_date].kind_of?(DateTime) ? hash[:to_date] : DateTime.parse(hash[:to_date])
        where('entry_date' => from_date..to_date).distinct.map{|a| a.credit_amounts.sum(:amount)}.sum
      else
        all.distinct.map{|a| a.credit_amounts.sum(:amount)}.sum
      end
    end
    def self.for_current_year
      where('entry_date' => Time.zone.now.beginning_of_year..Time.zone.now.end_of_year)
    end
    def paid!
      self.paid = true
      self.save
    end

    private
      def default_date
        todays_date = ActiveRecord::Base.default_timezone == :utc ? Time.now.utc : Time.now
        self.entry_date ||= todays_date
      end

      def has_credit_amounts?
        errors[:base] << "Entry must have at least one credit amount" if self.credit_amounts.blank?
      end

      def has_debit_amounts?
        errors[:base] << "Entry must have at least one debit amount" if self.debit_amounts.blank?
      end

      def amounts_cancel?
        errors[:base] << "The credit and debit amounts are not equal" if credit_amounts.balance_for_new_record != debit_amounts.balance_for_new_record
      end
  end
end
