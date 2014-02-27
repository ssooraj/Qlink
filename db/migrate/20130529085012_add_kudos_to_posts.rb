class AddKudosToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :kudos, :integer
  end
end
