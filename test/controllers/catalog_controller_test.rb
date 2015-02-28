require 'test_helper'
require 'minitest/unit'
require 'mocha/mini_test'

class CatalogControllerTest < ActionController::TestCase
  setup do
    @product = FactoryGirl.create(:product)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should post to add to cart" do
    post :add_to_cart, :id => @product.id, :format => 'js'
    assert_response :success
  end

test "check if button to add to cart placed correctly" do
  Product.stubs('find_products_for_sale').returns([@product])
  get :index
  assert_select '.add', 1
  end
end
