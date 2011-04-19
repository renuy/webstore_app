class BookList < ActiveRecord::Base
  belongs_to :users
  has_many :list_items
end
