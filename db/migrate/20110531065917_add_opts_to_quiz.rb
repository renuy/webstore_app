class AddOptsToQuiz < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :option_1, :string
    add_column :quizzes, :option_2, :string
    add_column :quizzes, :option_3, :string

  end

  def self.down
    remove_column :quizzes, :option_1
    remove_column :quizzes, :option_2
    remove_column :quizzes, :option_3
  end
end
