class Product < ActiveRecord::Base
  validates_presence_of :title,:desc,:image_link, :price
  validates :price, numericality: true
  validate :price_must_be_valid
  validates_uniqueness_of :title
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
end
