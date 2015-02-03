require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "price is not less than a cent" do
    prod = FactoryGirl.build(:product, :price=>1)
    assert prod.price  == 1
  end

 # test "price shouldnt be 0" do
    #prod = FactoryGirl.build(:product, :price=>'abc')
    #p prod.errors
  #end
end
