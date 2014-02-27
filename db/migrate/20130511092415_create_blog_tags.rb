class CreateBlogTags < ActiveRecord::Migration
  def change
    create_table :blog_tags do |t|
      t.string :name
      t.references :blog
      t.timestamps
    end
  end
end
