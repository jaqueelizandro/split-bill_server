class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :kind, default: 0
      t.text :description
      t.integer :amount
      t.datetime :date
      t.text :image
      t.uuid :group_id
      t.integer :member_id

      t.timestamps
    end
  end
end
