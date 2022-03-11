class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  paginates_per 20

  has_many :likes, dependent: :destroy
end
