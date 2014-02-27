class RemoveEndFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :end
  end

  def down
    add_column :events, :end, :date
  end
end
