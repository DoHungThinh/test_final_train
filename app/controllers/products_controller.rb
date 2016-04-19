class ProductsController < ApplicationController
  before_action :set_product, only: [:edit,:update, :destroy]
  before_action :add_image_without, only: [:edit]
  before_action :authenticate_user!, only: [:show,:new, :edit, :create, :update, :destroy, :my_products]
  before_action :own_product, only: [:edit, :update, :destroy]
  def index
    @products = Product.includes(:pictures).all.where(state:true).page params[:page]
    @categories = Category.all
  end
  def show
    @product = Product.includes(:pictures).find(params[:id])
    @pictures = @product.pictures
  end
  def my_products
    @products = current_user.products.includes(:pictures).all
  end
  def category_products
    @categories = Category.includes(:products).all
  end
  def new
    @product = current_user.products.build
    @categories = Category.all
    3.times do
    @product.pictures.build
    end
  end

  def edit
    @categories = Category.all

  end

  def create
    @product = current_user.products.new(product_params)
      respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :price, :category_id,:state,:pictures_attributes => [:id,:image,:_destroy])
    end
    def own_product
      if current_user.present?
        if !(@product.user == current_user)&& !current_user.admin?
          redirect_to products_path
        end
      end
    end
    def add_image_without
      if @product.pictures.size ==0 
        3.times do
          @product.pictures.build
        end
      elsif @product.pictures.size ==1
        2.times do
          @product.pictures.build
        end
      elsif @product.pictures.size ==2
        @product.pictures.build
      end
    end
end