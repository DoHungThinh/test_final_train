class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	has_many :pictures, :dependent => :destroy
	validates_each :pictures do |product, attr, value|
   product.errors.add attr, "too much for product" if product.pictures.size > 3
  end
	has_many :comments
	paginates_per 6
	accepts_nested_attributes_for :pictures
end
