class CreateTricycleFees < ActiveRecord::Migration[5.1]
  def change
    create_table :tricycle_fees, id: :uuid do |t|
      t.string :name
      t.decimal :amount
      t.boolean :default_fee

      t.timestamps
    end
  end
end
