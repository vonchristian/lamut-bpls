class AddModeOfPaymentToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_reference :businesses, :mode_of_payment, foreign_key: true, type: :uuid
  end
end
