class RemoveTransactionTypeFromTricyclePermitApplications < ActiveRecord::Migration[5.1]
  def change
    remove_column :tricycle_permit_applications, :transaction_type, :integer
  end
end
