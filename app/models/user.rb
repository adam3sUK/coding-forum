class User < ApplicationRecord
  has_one_attached :avatar
  has_secure_password

  has_many :topics
  has_many :posts
  has_many :messages
  has_one :inbox
end
