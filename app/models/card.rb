class Card < ActiveRecord::Base
belongs_to :member
belongs_to :plan
end
