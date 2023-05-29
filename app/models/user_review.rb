class UserReview < ApplicationRecord
  belongs_to :location

  validates :content, presence: true
end
