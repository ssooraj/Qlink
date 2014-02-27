class CreateUserevents < ActiveRecord::Migration
  def change
    create_table :userevents do |t|
      t.string :title
      t.string :description
      t.datetime :start
      t.datetime :endtime
      t.integer :user_id

      t.timestamps
    end
  end
end
