class Cart
	attr_reader :items #等於下面三行
	# def items
	# 	@items
	# end
	
	def initialize #任何要初始化的都放這裡
		@items = []
	end

	def empty?
		@items.empty?
	end

	def add_item(product_id)
		
		found_item = @items.find {|item| item.product_id == product_id}

		if found_item
			found_item.increment
		else
			@items << CartItem.new(product_id)
		end
		
	end



end