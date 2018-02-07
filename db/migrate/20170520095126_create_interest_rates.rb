class CreateInterestRates < ActiveRecord::Migration[5.1]
  def change
    create_table :interest_rates, id: :uuid do |t|
      t.decimal :rate

      t.timestamps
    end
  end
end
