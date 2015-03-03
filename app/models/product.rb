class Product < ActiveRecord::Base
  has_many :cart_items
  before_destroy :ensure_not_referenced_by_any_cart_item
  validates_presence_of :title,:desc,:image_link, :price #presence: true
  validates :price, numericality: true #numericality: {greater_than_or_equal_to: 0.01}
  validate :price_must_be_valid
  validates_uniqueness_of :title   #or validates :title, uniqueness: true
  validates_format_of :image_link, :with => /.*(gif|png|jpg)/i, :message => "Should be a gif,png or jpg file"

  def self.find_products_for_sale
    #Product.find(:all,:order => "title")
    Product.all.order(title: :asc)
  end

  protected
    def price_must_be_valid
      if(price.nil?||price < 0.01)
        errors.add(:price, "should be greater than a cent")
      end
    end

  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if cart_items.empty?
     return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
