class CreateDiscussionTags < ActiveRecord::Migration
  def change
    create_table :discussion_tags do |t|
      t.string :name
      t.references :discussion
      t.timestamps
    end
  end
end
