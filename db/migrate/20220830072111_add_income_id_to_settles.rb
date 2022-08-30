class AddIncomeIdToSettles < ActiveRecord::Migration[5.2]
  def change
    add_reference :settles, :income, index: true, foreign_key: { to_table: :transactions }
  end
end
