class RemoveEndFromEvent < ActiveRecord::Migration
  def up
    remove_column :events, :end
  end

  def down
    add_column :events, :end, :datetime
  end
end
