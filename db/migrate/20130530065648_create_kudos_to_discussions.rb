class CreateKudosToDiscussions < ActiveRecord::Migration
  def change
    create_table :kudos_to_discussions do |t|
      t.references :user
      t.references :discussion
      t.timestamps
    
    end
  end
end
