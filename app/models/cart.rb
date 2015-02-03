require 'cartItem.rb'

class Cart
   include Enumerable
  attr_accessor :items

  def initialize
    @items = []    #contains array of CartItem
  end

  def add_item item
    found = @items.find { |iteminarray|  item==iteminarray.product }
    if(found)
      found.inc_qty
    else
      @items << CartItem.new(item,1)
    end
      #@items << item
  end

  def sum
    @items.sum { |item| item.product.price * item.qty}
  end

end
