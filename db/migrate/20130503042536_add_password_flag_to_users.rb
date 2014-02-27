class AddPasswordFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :passwordflag, :boolean, default: false
  end
end
