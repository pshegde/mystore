class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :catch_js_response_errors

  private

  def catch_js_response_errors
    if response.content_type == 'text/javascript'
      literal_js = (response.body.strip.inspect)[1..-2]
      response.body = "try { eval(\"#{literal_js}\"); } \n catch(e) {console.log(e); }"
    end
  end


   def current_cart
   Cart.find(session[:cart_id])
   rescue ActiveRecord::RecordNotFound
   cart = Cart.create
   session[:cart_id] = cart.id
   cart
  end
end
