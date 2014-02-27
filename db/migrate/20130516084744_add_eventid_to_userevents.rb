class AddEventidToUserevents < ActiveRecord::Migration
  def change
    add_column :userevents, :eventid, :integer
  end
end
