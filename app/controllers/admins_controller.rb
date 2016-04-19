class AdminsController < ApplicationController
	layout 'admin'
	before_action :check_ad
	before_action :authenticate_user!
	before_action :set_product, only: [:disable_user, :active_user, :delete_user]
	def index
		@products= Product.includes(:pictures).all.page params[:page]
	end
	def list_user
		@users = User.all
	end
	def disable_user
		if @user.is_active?
			@user.is_active = false
			Product.transaction do
				@user.products.each do |p|
					p.state = false
					p.save
				end
			end
			@user.save
		end
		redirect_to admins_list_user_path
	end
	def active_user
		if !@user.is_active?
			@user.is_active = true
			Product.transaction do
				@user.products.each do |p|
					p.state = true
					p.save
				end
			end
			@user.save
		end
		redirect_to admins_list_user_path
	end
	def delete_user
		@user.destroy
		redirect_to admins_list_user_path
	end
	private
	def check_ad
		if !current_user.admin?
			redirect_to new_user_session_path
		end
	end
	 def set_product
      @user = User.includes(:products).find(params[:user])
    end

end
