module Accounting
  class Amount < ActiveRecord::Base
    belongs_to :entry, :class_name => 'Accounting::Entry', touch: true
    belongs_to :account, :class_name => 'Accounting::Account', touch: true
    belongs_to :commercial_document, polymorphic: true, touch: true

    validates :type, :amount, :entry, :account, presence: true
    validates :amount, numericality: true
    def self.entered_on(options={})
      first_entry_date = Accounting::Entry.order(entry_date: :desc).last.try(:entry_date) || Date.today
      from_date = options[:from_date] || first_entry_date
      to_date = options[:to_date] || Date.today
      date_range = DateRange.new(from_date: from_date, to_date: to_date)
      joins(:entry, :account).
      where('entries.entry_date' => date_range.start_date..date_range.end_date)
    end
    def self.exempted_by_fire_dept
      all.select{|a| a.exempted_in_fire_dept? }
    end

    def exempted_in_fire_dept?
      Accounting::Account::FIRE_DEPT_EXEMPTS.include?(account.name)
    end
  end
end
