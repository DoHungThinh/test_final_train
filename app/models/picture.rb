class Picture < ActiveRecord::Base
  belongs_to :product
  has_attached_file :image, styles: { medium: "350x400#", large: "400x500>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
