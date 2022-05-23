class AddGroupIdToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :group_id, :uuid
  end
end
