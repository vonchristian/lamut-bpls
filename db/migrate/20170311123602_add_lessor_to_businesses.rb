class AddLessorToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_reference :businesses, :lessor, foreign_key: true, type: :uuid
  end
end
