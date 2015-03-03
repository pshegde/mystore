require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase

  setup do
    @order1 = orders(:one)
  end

  test "received" do
    mail = OrderNotifier.received(@order1)
    assert_equal "order confirmation", mail.subject
    assert_equal ["to@example.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped
    assert_equal "Shipped", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
