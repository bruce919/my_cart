class CartsController < ApplicationController

	def add
		product = Product.find_by(id: params[:id])

		if product
			

			@cart.add_item(product.id)

			session[:my_shopping_carts426] = @cart.serialize

			redirect_to root_path, notice: "已放至購物車"

		elsif 
			redirect_to root_path, notice: "查無此商品"
		end
				
	end


end

