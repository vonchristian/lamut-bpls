require 'spec_helper'

module Accounting
  describe Expense do
    it_behaves_like 'a Accounting::Account subtype', kind: :expense, normal_balance: :debit
  end
end
