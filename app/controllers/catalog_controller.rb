class CatalogController < ApplicationController
  skip_before_action :verify_authenticity_token
  include ApplicationHelper
  skip_before_filter :authorize

  def index
    #byebug
    @products = Product.find_products_for_sale
    @cart = find_cart
  end

 # def view_cart
    #cart = find_cart
    #if(cart.cart_items.length <1)
      #redirect_to_index "Cart is empty"
    #else
      #redirect_to_index
    #end
  #end

  def find_cart
    #session[:cart] ||= Cart.new
    cart = current_cart
    cart
  end

  def add_to_cart
    #byebug
    #redirect_to '/cart_items/create_item', :product_id => params[:id]
    #@cart = current_cart
    #product = Product.find(params[:id])
    ##@cart = find_cart
    #@current_item = @cart.add_item product
    ##session[:cart] = @cart
    ##redirect_to_index
    #respond_to do |format|
      ##format.html {redirect_to_index}
      #format.js
      ##format.js { render plain: "OK" }
    #end
  #rescue ActiveRecord::RecordNotFound
    #logger.error("unable to find record with #{params[:id]}");
    #redirect_to_index "Record not found"
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

  def redirect_to_index msg=nil
    flash[:notice] = msg
    redirect_to :action => :index
  end
end
