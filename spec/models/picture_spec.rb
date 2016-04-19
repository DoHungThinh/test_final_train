require "rails_helper"

RSpec.describe Picture, :type => :model do
	context "belongs to Product" do
		it "linkin association" do
			product = Product.create!
			picture = Picture.new
			picture.image = File.new("app/assets/images/download.jpg")
			picture.product_id = product.id
			picture.save
			expect(picture.product).to eq(product)
		end
	end
	context "check attach" do
		it {should have_attached_file(:image) }
		it {should validate_attachment_presence(:image)}
		it {should validate_attachment_content_type(:image).
                allowing('image/png', 'image/jpeg')}
        it { should validate_attachment_size(:image).
                less_than(1.megabytes)}
	end
end