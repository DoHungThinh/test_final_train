class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]
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

  # GET /products/1/edit
  def edit
    3.times { @product.pictures.build } # ... and this
    @categories = Category.all

  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.new(product_params)
    @product.category_id = params[:category_id]
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

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.category_id = params[:category_id]
        @product.save
        if params[:images]
        #===== The magic is here ;)
        params[:images].each { |image|
          @product.pictures.create(image: image)
        }
      end
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
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
      params.require(:product).permit(:title, :description, :price, :category_id,:state,:pictures_attributes => [:image])
    end
    def own_product
      if current_user.present?
        if !(@product.user == current_user)&& !current_user.admin?
          redirect_to products_path
        end
      end
    end
end