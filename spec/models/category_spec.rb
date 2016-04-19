require "rails_helper"

RSpec.describe Category, :type => :model do
	context "has many products" do
		it "linkin association" do
			category = Category.new
			category.image = File.new("app/assets/images/download.jpg")
			category.save
			product = Product.new
			product.category_id = category.id
			expect(category).to eq(product.category)
		end
	end
	context "check attach" do
		it { should have_attached_file(:image) }
		it {should validate_attachment_presence(:image)}
		it {should validate_attachment_content_type(:image).
                allowing('image/png', 'image/jpeg')}
        it { should validate_attachment_size(:image).
                less_than(1.megabytes)}
	end
end