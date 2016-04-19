RSpec.describe Product, :type => :model do
  context "with 2 or more comments" do
    it "orders them " do
      product = Product.create!
      comment1 = product.comments.create!(:body => "first comment")
      comment2 = product.comments.create!(:body => "second comment")
      expect(product.reload.comments).to eq([comment1, comment2])
    end
    it "in reverse chronologically" do
    	product = Product.create!
    	comment1 = product.comments.create!(:body => "first comment")
      	comment2 = product.comments.create!(:body => "second comment")
      expect(product.reload.comments).not_to eq([comment2, comment1])
    end
  end
end