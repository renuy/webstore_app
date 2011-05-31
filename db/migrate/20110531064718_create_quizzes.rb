class CreateQuizzes < ActiveRecord::Migration
  def self.up
    create_table :quizzes do |t|
      t.references :title
      t.string :question
      t.string :answer
      t.string :cue
      t.timestamps
    end
  end

  def self.down
    drop_table :quizzes
  end
end
