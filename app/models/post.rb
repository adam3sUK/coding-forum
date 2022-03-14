class Post < ApplicationRecord
  belongs_to :topic, :touch => true
  belongs_to :user
  paginates_per 2

  has_many :likes, dependent: :destroy
end
