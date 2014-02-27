class AddKudosToComments < ActiveRecord::Migration
  def change
    add_column :comments, :kudos, :integer,:default => 0, :null => false
  end
end
