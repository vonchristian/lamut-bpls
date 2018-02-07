shared_examples_for 'a Accounting::Amount subtype' do |elements|
  let(:amount) { FactoryBot.build(elements[:kind]) }
  subject { amount }

  it { should be_valid }

  it "should require an amount" do
    amount.amount = nil
    amount.should_not be_valid
  end

  it "should require a entry" do
    amount.entry = nil
    amount.should_not be_valid
  end

  it "should require an account" do
    amount.account = nil
    amount.should_not be_valid
  end
end
