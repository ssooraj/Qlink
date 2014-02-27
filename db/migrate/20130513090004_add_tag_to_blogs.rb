class AddTagToBlogs < ActiveRecord::Migration
  def change

    add_column :blogs, :tag, :text

  end
end
