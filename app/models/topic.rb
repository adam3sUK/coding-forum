class Topic < ApplicationRecord
  validates :title, presence: true, length: { minimum: 8 }
  belongs_to :user
  has_many :posts, dependent :destroy

end
