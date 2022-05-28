class CreateSettles < ActiveRecord::Migration[5.2]
  def change
    create_table :settles do |t|
      t.references :transaction, index: true, foreign_key: true
      t.references :paid_for, index: true, foreign_key: { to_table: :members }

      t.timestamps
    end
  end
end
