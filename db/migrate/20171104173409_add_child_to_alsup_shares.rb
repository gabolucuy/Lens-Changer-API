class AddChildToAlsupShares < ActiveRecord::Migration[5.1]
  def change
    add_reference :alsup_shares, :child, foreign_key: true
  end
end
