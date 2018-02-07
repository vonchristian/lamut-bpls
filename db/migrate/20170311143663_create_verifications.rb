class CreateVerifications < ActiveRecord::Migration[5.1]
  def change
    create_table :verifications, id: :uuid do |t|
      t.belongs_to :business_requirement, foreign_key: true, type: :uuid
      t.string :reference_number
      t.datetime :submission_date
      t.string :remarks

      t.timestamps
    end
  end
end
