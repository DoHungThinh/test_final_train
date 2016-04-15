class Category < ActiveRecord::Base
has_many :products
has_attached_file :image, styles: { medium: "350x400#", thumb: "100x100>" }
validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
paginates_per 12
end
