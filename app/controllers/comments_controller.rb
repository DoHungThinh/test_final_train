class CommentsController < ApplicationController
	def create
		@product = Product.find(params[:product_id])
		@comment = @product.comments.create(params[:comment].permit(:name, :body))
		@comment.user_id = current_user.id
		@comment.save
		redirect_to product_path(@product)
	end


	def destroy
		@product = Product.find(params[:product_id])
		@comment = @product.comments.find(params[:id])
		if current_user==@comment.user|| current_user.admin?
			@comment.destroy
			redirect_to product_path(@product)
		else
			redirect_to product_path(@product)
		end
	end
end
