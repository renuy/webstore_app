class Member < ActiveRecord::Base
belongs_to :user
has_many :card
belongs_to :branch
has_many :read_shelf
has_many :read_next_shelf
end
