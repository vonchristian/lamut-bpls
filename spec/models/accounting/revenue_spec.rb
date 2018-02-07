require 'spec_helper'

module Accounting
  describe Revenue do
    it_behaves_like 'a Accounting::Account subtype', kind: :revenue, normal_balance: :credit
  end
end
