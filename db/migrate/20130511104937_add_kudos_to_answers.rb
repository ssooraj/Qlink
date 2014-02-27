class AddKudosToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :kudos, :integer, :default => 0, :null => false
  end
end
