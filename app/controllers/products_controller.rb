class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all

    if params[:search].present?
      @products = @products.where("product_name LIKE ?", "%#{params[:search]}%")
    end

    return unless params[:category].present?

    @products = @products.where(category_id: params[:category])
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  def search
    @input = params[:search]
    @selected_category = Category.find_by(id: params[:category]) # Use find_by to avoid raising an exception if the location is not found

    if params[:search].present?
      if @selected_category.present?
        # Query and Category are present
        @products_in = Product.where(category_id: @selected_category.id)
                              .where("product_name LIKE ?", "%#{@input}%").order(:product_name)
      else
        # Query present but category not selected
        @products_in = Product.where("product_name LIKE ?", "%#{@input}%").order(:product_name)
      end
    elsif @selected_category.present?
      # Category selected but no query
      @products_in = Product.where(category_id: @selected_category).order(:product_name)
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to product_url(@product), notice: "Product was successfully created."
        end
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html do
          redirect_to product_url(@product), notice: "Product was successfully updated."
        end
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:categories_id, :product_name, :price, :description,
                                    :stock_quantity, :image)
  end
end
