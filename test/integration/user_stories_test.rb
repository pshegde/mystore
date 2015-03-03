require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  setup do
    CartItem.delete_all
    Order.delete_all
    @ruby_book = products(:ruby)
    #session[:cart_id] = nil
  end

  # test "the truth" do
  #   assert true
  # end

  test "a user goes to the store index" do
    get '/'
    assert_response :success
    assert_template "index"

    xml_http_request :post, "/cart_items?product_id=" + @ruby_book.id.to_s
    assert_response :success
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.cart_items.size
    assert_equal @ruby_book, cart.cart_items[0].product

    post_via_redirect "/orders",
          order: { name: "Dave Thomas",
          address: "123 The Street",
          email: "dave@example.com",
          pay_type: "Check" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.cart_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    assert_equal "Dave Thomas", order.name
    assert_equal "123 The Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check", order.pay_type
    assert_equal 1, order.cart_items.size
    cart_item = order.cart_items[0]
    assert_equal @ruby_book, cart_item.product


    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'PSH <depot@example.com>', mail[:from].value
    assert_equal "order confirmation", mail.subject
  end
end
