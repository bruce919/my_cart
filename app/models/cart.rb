class Cart

	def initialize #任何要初始化的都放這裡
		@items = []
	end

	def empty?
		@items.empty?
	end

	def add_item(product_id)
		@items << product_id #把產品丟進去
	end

end