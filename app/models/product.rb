class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	has_many :pictures, :dependent => :destroy
	has_many :comments
	paginates_per 6
end
