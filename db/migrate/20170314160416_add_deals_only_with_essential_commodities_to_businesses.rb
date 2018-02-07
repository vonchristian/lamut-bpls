class AddDealsOnlyWithEssentialCommoditiesToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :deals_only_with_essential_commodities, :boolean, default: :false
  end
end
