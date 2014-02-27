class CreateKudosToAnswers < ActiveRecord::Migration
  def change
    create_table :kudos_to_answers do |t|
      t.references :user
      t.references :answer
      t.timestamps
    end
  end
end
