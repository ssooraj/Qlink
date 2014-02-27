class AddTagToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :tag, :string
  end
end
