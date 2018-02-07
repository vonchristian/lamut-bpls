require 'rails_helper'

module Accounting
  describe Asset do
    it_behaves_like 'a Accounting::Account subtype', kind: :asset, normal_balance: :debit
  end
end
