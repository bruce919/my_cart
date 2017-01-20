class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart

  private
  def set_cart
  	@cart = Cart.from_hash(session[:my_shopping_carts426])
  end
end
