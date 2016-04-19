class Category < ActiveRecord::Base
has_many :products
has_attached_file :image, styles: { medium: "350x400", large: "350x400#" }
validates_attachment :image, presence: true,
  content_type: { content_type: ["image/jpeg","image/png"] },
  size: { in: 0..1.megabytes }
paginates_per 12
end
