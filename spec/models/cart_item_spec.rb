require 'rails_helper'

RSpec.describe CartItem, type: :model do

  it "每個 Cart Item 都可以計算它自己的金額(小計)" do
    p1 = Product.create(price: 100)
    p2 = Product.create(price: 200)

    cart = Cart.new
    5.times { cart.add_item(p1.id) }
    3.times { cart.add_item(p2.id) }

    expect(cart.items.first.price).to be 500
    expect(cart.items.last.price).to be 600
  end
end
