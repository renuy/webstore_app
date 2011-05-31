class Quiz < ActiveRecord::Base
  belongs_to :title

  validates :title_id, :presence => true
  validates :question, :presence => true
  validates :answer, :presence => true
  validates :cue, :presence => true
  validates :option_1, :presence => true
  validates :option_2, :presence => true
  validates :option_3, :presence => true
end
