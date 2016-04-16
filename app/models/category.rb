class Category < ActiveRecord::Base
has_many :products
has_attached_file :image, styles: { medium: "350x400", large: "350x400#" }
validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
paginates_per 12
end
