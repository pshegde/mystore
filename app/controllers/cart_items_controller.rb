require 'carts_controller.rb'

class CartItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_filter :authorize, only: :create
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = CartItem.all
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @cart_item = @cart.add_product(product.id)
    #@cart_item = @cart.cart_items.build(product: product)
    #@cart_item = CartItem.new(cart_item_params)

    respond_to do |format|
      if @cart_item.save
        #format.html { redirect_to @cart_item.cart, notice: 'Cart item was successfully created.' }
        format.js
        #format.json { render :show, status: :created, location: @cart_item }
      else
        #format.html { render :new }
        #format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_product(product_id)
    current_item = cart_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(product_id: product_id)
    end
    current_item
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to @cart_item, notice: 'Cart item was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: 'Cart item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 def delete_all
   # session.delete(:cart)
    #@cart = find_cart
    #redirect_to_index "cart is empty"
    ##render :add_to_cart     #directly call the view
    #respond_to do |format|
      #format.json { head :no_content }
    #end
    redirect_to :controller => "cart_items", :action => "delete"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:product_id, :cart_id)
    end
end
