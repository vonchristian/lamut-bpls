class CreateBirRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :bir_registrations, id: :uuid do |t|
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.datetime :date_issued
      t.datetime :expiry_date
      t.string :registration_number

      t.timestamps
    end
  end
end
