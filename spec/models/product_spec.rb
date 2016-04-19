require "rails_helper"

RSpec.describe Product, :type => :model do
  context "create category through product" do
   	  it "linkin association" do
   	  	product = Product.create!
   	  	category = Category.new(:name => "first category")
        category.image = File.new("app/assets/images/download.jpg")
        category.save
        product.category_id = category.id
        product.save
   	  	expect(product.category).to eq(category)
   	  end
  end
  context "create picture through product" do
      it "linkin association" do
        product = Product.create!
        picture = Picture.new()
        picture.image = File.new("app/assets/images/download.jpg")
        picture.product_id = product.id
        picture.save
        expect(product.pictures.first).to eq(picture)
      end
  end
end