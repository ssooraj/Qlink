class CreateKudosToPosts < ActiveRecord::Migration
  def change
    create_table :kudos_to_posts do |t|
      t.integer :kudos
      t.references :user
      t.references :post
      t.timestamps
    end
  end
end
