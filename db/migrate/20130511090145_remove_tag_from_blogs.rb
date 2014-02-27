class RemoveTagFromBlogs < ActiveRecord::Migration
  def up
    remove_column :blogs, :tag
  end

  def down
    add_column :blogs, :tag, :string
  end
end
