class Cart

	attr_reader :items #等於下面三行
	# def items
	# 	@items
	# end
	
	def initialize #任何要初始化的都放這裡
		@items = []
	end

	def empty?
		@items.empty? #@可以拿掉
	end

	def add_item(product_id)
		
		found_item = @items.find {|item| item.product_id == product_id}

		if found_item
			found_item.increment
		else
			@items << CartItem.new(product_id) #@可以拿掉
		end
		
	end

	def total_price
		# total = 0
		# items.each |item| do
		# 	total += item.price
		# end
		# totsl  累加的方式可以寫成下面
		total = items.reduce(0){|sum, item| sum + item.price}

		if xmas
			total * 0.9
		else
			total
		end
	end


	def  serialize
		result = []

		items.each do |item|
			result << { "product_id" => item.product_id, "quantity" => item.quantity }
		end

		# result = items.map { |item|{ "product_id" => item.product_id, "quantity" => item.quantity } }

		{ "items" => result }
	end

	def cart_item_hash 



	end
	private
	def xmas
		Date.today.month == 12 && Date.today.day == 25
	end


end