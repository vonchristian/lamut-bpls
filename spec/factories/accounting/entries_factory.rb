FactoryBot.define do
  factory :entry, :class => Accounting::Entry do |entry|
    entry.description 'factory description'
    factory :entry_with_credit_and_debit, :class => Accounting::Entry do |entry_cd|
      entry_cd.after(:build) do |t|
        t.credit_amounts << FactoryBot.build(:credit_amount, entry_id: t.id)
        t.debit_amounts << FactoryBot.build(:debit_amount, entry_id: t.id)
      end
    end
  end
end
