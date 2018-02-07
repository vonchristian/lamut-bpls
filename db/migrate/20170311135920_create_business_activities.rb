class CreateBusinessActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :business_activities, id: :uuid do |t|
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.belongs_to :line_of_business, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
