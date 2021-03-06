class Photo < ActiveRecord::Base
  belongs_to :bead

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ActionController::Base.helpers.asset_path("/images/:style/missing.png")
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end