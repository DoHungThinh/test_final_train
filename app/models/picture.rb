class Picture < ActiveRecord::Base
  belongs_to :product
  validates_associated :product
  has_attached_file :image, styles: { medium: "350x400#", large: "400x500#" }
  validates_attachment :image, presence: true,
  content_type: { content_type: ["image/jpeg","image/png"] },
  size: { in: 0..1.megabytes }
end
