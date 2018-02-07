class CreateLatePaymentSurcharges < ActiveRecord::Migration[5.1]
  def change
    create_table :late_payment_surcharges, id: :uuid do |t|
      t.decimal :rate

      t.timestamps
    end
  end
end
