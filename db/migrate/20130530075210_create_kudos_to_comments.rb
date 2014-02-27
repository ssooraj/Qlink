class CreateKudosToComments < ActiveRecord::Migration
  def change
    create_table :kudos_to_comments do |t|
      t.references :user
      t.references :comment
      t.timestamps
    end
  end
end
