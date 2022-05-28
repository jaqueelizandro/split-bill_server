class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :kind, default: 0
      t.text :description
      t.integer :amount
      t.datetime :date
      t.text :image
      t.references :group, index: true, foreign_key: true, type: :uuid
      t.references :member, index: true, foreign_key: true

      t.timestamps
    end
  end
end
