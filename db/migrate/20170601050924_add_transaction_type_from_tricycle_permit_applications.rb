class AddTransactionTypeFromTricyclePermitApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :tricycle_permit_applications, :transaction_type, :integer, default: 1
  end
end
