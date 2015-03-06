require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :products

  test "price is not less than a cent" do
    prod = FactoryGirl.build(:product, :price=>1)
    assert prod.price  == 1
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:desc].any?
    assert product.errors[:price].any?
    assert product.errors[:image_link].any?
  end
 # test "price shouldnt be 0" do
    #prod = FactoryGirl.build(:product, :price=>'abc')
    #p prod.errors
  #end
  #
  test "product price must be positive" do
    product = Product.new(title: "My Book Title",
                          desc: "yyy",
                          image_link: "zzz.jpg")
    product.invalid?
    puts product.errors[:price].join(' ')
    assert product.errors[:price].include?('should be greater than a cent')
    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gifmore fred.gif.more }
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
        desc: "yyy",
        price: 1,
        image_link: "fred.gif")
    assert !product.save
    assert_equal "has already been taken", product.errors[:title].join('; ')
  end

  private

  def new_product(image_url)
    Product.new(title: "My Book Title",
      desc: "yyy",
      price: 1,
      image_link: image_url)
  end
end
