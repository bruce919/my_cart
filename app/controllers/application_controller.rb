class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart

  private
  CART_SESSION = :my_shopping_cart426

  def set_cart
    @cart = Cart.from_hash(session[CART_SESSION])
  end

  def user_only!
    redirect_to cart_path, alert: '請先登入會員' unless user_signed_in?
  end
end
