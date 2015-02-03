class CartItem
  attr_accessor :qty, :product
  def initialize product,qty
    @qty = qty
    @product = product
  end

  def inc_qty
    @qty += 1
  end

end
