class Bead < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :orders
  has_many :reviews

  validates :waist_size, presence: true
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end
end