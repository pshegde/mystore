require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @update = {
      title: 'Lorem Ip',
      desc: 'dgkdnfgfd',
      image_link: 'lorem.jpg',
      price: 19.9
    }
    @user = FactoryGirl.create(:user1)
    @cart = carts(:one)
    session[:user_id] = @user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @update #{ desc: @product.desc, image_link: @product.image_link, title: @product.title }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { desc: @product.desc, image_link: @product.image_link, title: @product.title }
    #assert_redirected_to product_path(assigns(:product))
    assert_response :success
  end

  test "should destroy product" do
    Product.stubs(:ensure_not_referenced).returns(true)
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
