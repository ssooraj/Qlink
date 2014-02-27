class CreateEventemails < ActiveRecord::Migration
  def change
    create_table :eventemails do |t|
      t.integer :event_id
      t.string :email

      t.timestamps
    end
  end
end
