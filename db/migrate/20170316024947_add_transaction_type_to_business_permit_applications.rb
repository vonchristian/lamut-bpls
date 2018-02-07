class AddTransactionTypeToBusinessPermitApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :business_permit_applications, :transaction_type, :integer
  end
end
