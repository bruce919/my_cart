class OrdersController < ApplicationController
  before_action :user_only!, only: [:create, :index, :cancel, :show]

  def index
  	@orders = current_user.orders #以使用者角度
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    redirect_to orders_path, alert: "查無此訂單" unless @order
  end


  def cancel
  	# order = Order.find_by(id: params[:id],user_id: current_user.id)
    order = current_user.orders.find_by(id: params[:id])
    if order && order.may_cancel?
      order.cancel!
      redirect_to orders_path, notice: "訂單已取消"
    else
      redirect_to orders_path, alert: "訂單無法取消"
    end
  end

  

  def create
    # 建立訂單

	    build_order

	  	if @order.save

	  	#刷卡
			  if payment.success?
		  	#清空購物車
		  	session[CART_SESSION] = nil
		  	#轉往首頁
		  		redirect_to root_path, notice: "感謝您"
		  	else 
		  		redirect_to root_path,alert: "失敗"
	  	end


	  end
	end

  private
  def order_params
  	params.require(:order).permit(:receipent, :tel, :address, :company_id)
  end

  private

  def payment
  	Braintree::Transaction.sale(
		  :amount => @cart.total_price,
		  :payment_method_nonce => params[:payment_method_nonce]
	)
  end

  def build_order
  	@order = current_user.orders.build(order_params)
    @cart.items.each do |item|
      @order.order_items.build(
        product: item.product,
        quantity: item.quantity,
        price: item.price
      )
    end
  end

end
