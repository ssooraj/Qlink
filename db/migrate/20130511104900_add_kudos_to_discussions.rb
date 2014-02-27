class AddKudosToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :kudos, :integer, :default => 0, :null => false
  end
end
