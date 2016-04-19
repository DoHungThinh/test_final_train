class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	has_many :pictures, :dependent => :destroy
	# has_many :pictures, :dependent => :destroy do
	# 	def length
	# 		reject(&:marked_for_destruction?).length
	# 	end
	# end
	has_many :comments
	paginates_per 6
	accepts_nested_attributes_for :pictures, allow_destroy: true
	# validates :pictures, length: {minimum: 1}
end
