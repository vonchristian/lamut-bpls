require 'spec_helper'

module Accounting
  describe Liability do
    it_behaves_like 'a Accounting::Account subtype', kind: :liability, normal_balance: :credit
  end
end
