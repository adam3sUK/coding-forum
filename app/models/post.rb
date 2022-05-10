class Post < ApplicationRecord
  belongs_to :topic, :touch => true
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_rich_text :content
end
