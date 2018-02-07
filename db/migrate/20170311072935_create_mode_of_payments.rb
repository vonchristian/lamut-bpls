class CreateModeOfPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :mode_of_payments, id: :uuid do |t|
      t.string :mode

      t.timestamps
    end
    add_index :mode_of_payments, :mode, unique: true
  end
end
