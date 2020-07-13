class Review < ActiveRecord::Base
  belongs_to :bead
  belongs_to :user
end