class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_cart


  attr_reader :current_user

  private
  CART_SESSION = :my_shopping_cart426

  def set_cart
    @cart = Cart.from_hash(session[CART_SESSION])
  end

  def user_only!
    redirect_to cart_path, alert: '請先登入會員' unless user_signed_in?
  end


  #JWT驗證token是否有效
  protected
  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['驗證失敗'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['驗證失敗'] }, status: :unauthorized
  # rescue JWT::ExpiredSignature
  #   render_failed ['授權已過期']
  end

  private
  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
