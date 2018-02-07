require 'rails_helper'

module Accounting
  describe DebitAmount do
    it_behaves_like 'a Accounting::Amount subtype', kind: :debit_amount
  end
end
