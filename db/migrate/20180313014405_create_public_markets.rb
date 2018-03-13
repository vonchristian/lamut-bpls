class CreatePublicMarkets < ActiveRecord::Migration[5.1]
  def change
    create_table :public_markets, id: :uuid do |t|
      t.string :address
      t.string :name

      t.timestamps
    end
  end
end
