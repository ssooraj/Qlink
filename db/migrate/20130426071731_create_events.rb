class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.date :start
      t.date :end
      t.string :allday
      t.references :user
      t.timestamps
    end
  end
end
