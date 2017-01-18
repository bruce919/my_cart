require 'rails_helper'


RSpec.describe Cart, type: :model do

describe "基本功能" do

	let(:cart){Cart.new} #等於 cart = Cart.new
	let(:p1){Product.create(title:"P1", price: 100)}
	let(:p2){Product.create(title:"P2", price: 200)} 
	it "可以新增商品到購物車裡，然後購物車裡就有東西了。" do
		
		# expect(cart.empty?).to be true 正確寫法，但寫下面更好懂
		expect(cart).to be_empty

		cart.add_item(1)
		# expect(cart.empty?).to be false 正確寫法，但寫下面更好懂
		expect(cart).not_to be_empty
	end

	it "如果加了相同種類的商品到購物車裡，購買項目(CartItem)並不會增加，但數量會改變。" do
		# cart = Cart.new
		5.times{ cart.add_item(1)}
		3.times{ cart.add_item(2)}

		expect(cart.items.count).to be 2
		expect(cart.items.first.quantity).to be 5
		expect(cart.items.last.quantity).to be 3

	end

	it "商品可以放到購物車裡，也可以再拿出來。" do
		# p1 = Product.create(title:"p1", price: 100)

		cart.add_item(p1.id)

		expect(cart.items.first.product).to be_a Product
		expect(cart.items.first.product.price).to be 100

	end

	it "可以計算整台購物車的總消費金額。" do
		# p1 = Product.create(price:100) 用 let 定義了
  # 	p2 = Product.create(price:200) 用 let 定義了

  	# cart = Cart.new 用 let 定義了

  	5.times {cart.add_item(p1.id)}
		3.times {cart.add_item(p2.id)}

	end


	it "特別活動可能可搭配折扣(例如聖誕節的時候全面打 9 折，或是滿額滿千送百" do
		# p1 = Product.create(price:100) 用 let 定義了
  # 	p2 = Product.create(price:200) 用 let 定義了

  	# cart = Cart.new 用 let 定義了

  	5.times {cart.add_item(p1.id)}
		3.times {cart.add_item(p2.id)}

		Timecop.travel(Time.local(2008,12,24,10,5,0))
		expect(cart.total_price).to be 1100

		Timecop.travel(Time.local(2008,12,25,10,5,0))
		expect(cart.total_price).to be 1100 * 0.9

	end

	


	end

	describe "進階功能" do

	#* 因為購物車將以 Session 方式儲存，所以：
	  #* 可以將購物車內容轉換成 Hash
	  #* 也可以把 Hash 還原成購物車的內容

	end


end
