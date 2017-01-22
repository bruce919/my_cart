class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart

  private
  CART_SESSION = :my_shopping_cart426

  def set_cart
    @cart = Cart.from_hash(session[CART_SESSION])
  end
end
