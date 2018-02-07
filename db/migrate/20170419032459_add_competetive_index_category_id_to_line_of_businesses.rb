class AddCompetetiveIndexCategoryIdToLineOfBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_reference :line_of_businesses, :competetive_index_category, foreign_key: true, type: :uuid
  end
end
