class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.text :name
      t.text :email
      t.references :group, index: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
