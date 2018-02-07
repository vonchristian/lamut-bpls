FactoryBot.define do
  factory :account, :class => Accounting::Account do |account|
    account.name
    account.contra false
  end

  factory :asset, :class => Accounting::Asset do |account|
    account.name
    account.contra false
  end

  factory :equity, :class => Accounting::Equity do |account|
    account.name
    account.contra false
  end

  factory :expense, :class => Accounting::Expense do |account|
    account.name
    account.contra false
  end

  factory :liability, :class => Accounting::Liability do |account|
    account.name
    account.contra false
  end

  factory :revenue, :class => Accounting::Revenue do |account|
    account.name
    account.contra false
  end

  sequence :name do |n|
    "Factory Name #{n}"
  end
end
