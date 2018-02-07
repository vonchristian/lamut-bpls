class CreatePaymentSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_schedules, id: :uuid do |t|
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.decimal :amount
      t.datetime :payment_date

      t.timestamps
    end
  end
end
