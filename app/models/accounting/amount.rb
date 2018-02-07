module Accounting
  class Amount < ActiveRecord::Base
    belongs_to :entry, :class_name => 'Accounting::Entry'
    belongs_to :account, :class_name => 'Accounting::Account'

    validates :type, :amount, :entry, :account, presence: true
    validates :amount, numericality: { greater_than: 0.1 }

    def self.exempted_by_fire_dept
      all.select{|a| a.exempted_in_fire_dept? }
    end

    def exempted_in_fire_dept?
      Accounting::Account::FIRE_DEPT_EXEMPTS.include?(account.name)
    end
  end
end
