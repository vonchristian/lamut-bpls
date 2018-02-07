require 'rails_helper'

module Accounting
  describe CreditAmount do
    it_behaves_like 'a Accounting::Amount subtype', kind: :credit_amount
  end
end
