class CartItem < ActiveRecord::Base
  #attr_accessor :qty, :product
  belongs_to :product #, :foreign_key => :product_id
  belongs_to :cart #, :foreign_key => :cart_id
  belongs_to :order
  #def initialize product,qty
    #@qty = qty
    #@product = product
  #end

  #def inc_qty
    #@qty += 1
  #end
  #
  def total_price
    product.price * quantity
  end
end
