class CreateIssuances < ActiveRecord::Migration[5.1]
  def change
    create_table :issuances, id: :uuid do |t|
      t.belongs_to :business_requirement, foreign_key: true, type: :uuid
      t.datetime :issue_date
      t.string :reference_number

      t.timestamps
    end
  end
end
