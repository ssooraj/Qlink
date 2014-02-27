class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :blog
      t.text :content
      t.references :user
      t.timestamps
    end
  end
end
