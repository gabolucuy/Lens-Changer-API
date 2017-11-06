class CreateAlsupShares < ActiveRecord::Migration[5.1]
  def change
    create_table :alsup_shares do |t|

      t.timestamps
    end
  end
end
