class AddEventIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :eventId, :string
  end
end
