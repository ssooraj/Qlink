class AddKudosToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :kudos, :integer, :default => 0, :null => false
  end
end
