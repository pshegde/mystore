class CatalogController < ApplicationController
  def index
    #byebug
    @products = Product.find_products_for_sale
  end

  def view_cart
    @cart = find_cart
    if(@cart.items.length <1)
      redirect_to_index "Cart is empty"
    else
      render :add_to_cart
    end
  end

  def find_cart
    session[:cart] ||= Cart.new
  end

  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @cart.add_item product
  rescue ActiveRecord::RecordNotFound
    logger.error("unable to find record with #{params[:id]}");
    redirect_to_index "Record not found"
  end

  def delete_all
    session.delete(:cart)
    @cart = find_cart
    redirect_to_index "Cart is empty"
    #render :add_to_cart     #directly call the view
  end

  def redirect_to_index msg
    flash[:notice] = msg
    redirect_to :action => :index
  end
end
