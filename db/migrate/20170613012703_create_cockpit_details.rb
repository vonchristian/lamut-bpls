class CreateCockpitDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :cockpit_details, id: :uuid do |t|
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.integer :promoter_count, default: 0
      t.integer :pit_manager_count, default: 0
      t.integer :referee_count, default: 0
      t.integer :bet_taker_count, default: 0
      t.integer :bet_manager_count,default: 0
      t.integer :gaffer_count, default: 0
      t.integer :cashier_count, default: 0
      t.integer :derby_count, default: 0
      t.timestamps
    end
  end
end
