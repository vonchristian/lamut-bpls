require 'spec_helper'

module Accounting
  describe Equity do
    it_behaves_like 'a Accounting::Account subtype', kind: :equity, normal_balance: :credit
  end
end
