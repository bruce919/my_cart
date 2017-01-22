class OrdersController < ApplicationController
  before_action :user_only!, only: [:create]

  def create
    # 建立訂單

    @order = current_user.orders.build(order_params)
    @cart.items.each do |item|
      @order.order_items.build(
        product: item.product,
        quantity: item.quantity,
        price: item.price
      )
    end

  	if @order.save
  		redirect_to root_path, notice: "新增訂單成功"
  	else 
  		redirect_to root_path,alert: "失敗"
  	end

  	#刷卡

  	#清空購物車

  	#轉往首頁

  end

  private
  def order_params
  	params.require(:order).permit(:receipent, :tel, :address, :company_id)
  end
end
