class Cart

	attr_reader :items #等於下面三行
	# def items
	# 	@items
	# end
	
	def initialize(items = []) #任何要初始化的都放這裡
		@items = items
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

	def self.from_hash(hash)
	
		if hash && hash["items"]
			# result = []
			# hash["items"].each do |item_hash|
			# 	result << CartItem.new(item_hash["product_id"],item_hash["quantity"])
			# end
			result = hash["items"].map {|item_hash| CartItem.new(item_hash["product_id"],item_hash["quantity"])}
			Cart.new(result)
		else
			Cart.new
		end


	end
  #self.from_hash....類別方法也可以這樣寫 
	# class < self 
	# 	def from_hash(hash)

	# 	end
	# end

	private
	def xmas
		Date.today.month == 12 && Date.today.day == 25
	end


end