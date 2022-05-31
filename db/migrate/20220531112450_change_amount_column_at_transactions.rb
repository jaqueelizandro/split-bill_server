class ChangeAmountColumnAtTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :amount, :decimal
  end
end
