
class Cart < ActiveRecord::Base

   include Enumerable
  #attr_accessor :items
  has_many :cart_items, dependent: :destroy
def add_product(product_id)
    current_item = cart_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(product_id: product_id)
    end
    current_item
  end


#  def initialize
    #@items = []    #contains array of CartItem
  #end

  #def add_item item
    ##find items for this cart
    #@items = cart_items
    #found = @items.find { |iteminarray|  item==iteminarray.product }
    #if(found)
      #found.inc_qty
      #found
    #else
      #item = CartItem.new(item,1)
      #@items << item
      #item
    #end
    ##save items in the cartitem table

  #end

  def sum
    cart_items.to_a.sum { |item| item.product.price * item.quantity}
  end

end
