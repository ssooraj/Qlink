class RemoveTagFromDiscussions < ActiveRecord::Migration
  def up
    remove_column :discussions, :tag
  end

  def down
    add_column :discussions, :tag, :string
  end
end
