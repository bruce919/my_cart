class CartItem

	attr_reader :product_id #等於底下三行
	# def product_id
	# 	@product_id
	# end

	attr_reader :quantity #等於底下三行
	# def quantity
	# 	@quantity
	# end
	def initialize(product_id, quantity = 1)
		@product_id = product_id
		@quantity = quantity

	end

	def increment(n = 1)
		@quantity += n if n > 0 #不能傳負值

	end

end