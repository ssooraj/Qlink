class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :discussion
      t.text :content
      t.references :user
      t.timestamps
    end
  end
end
