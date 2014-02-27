class CreateKudosToBlogs < ActiveRecord::Migration
  def change
    create_table :kudos_to_blogs do |t|
      t.references :user
      t.references :blog
      t.timestamps
    end
  end
end
