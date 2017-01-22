require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "基本功能" do
    let(:cart) { Cart.new }
    let(:p1) { Product.create(title: "P1", price: 100) }
    let(:p2) { Product.create(title: "P2", price: 200) }

    it "可以計算含稅未稅" do
      5.times { cart.add_item(p1.id) }
      3.times { cart.add_item(p2.id) }

      expect(cart.total_price_without_tax).to be (1100 / 1.05).round
      expect(cart.tax).to be (1100 - (1100 / 1.05)).round
    end

    it "可以新增商品到購物車裡，然後購物車裡就有東西了。" do
      expect(cart).to be_empty

      cart.add_item(1)
      expect(cart).not_to be_empty
    end

    it "如果加了相同種類的商品到購物車裡，購買項目(CartItem)並不會增加，但數量會改變" do
      5.times { cart.add_item(1) }
      3.times { cart.add_item(2) }
      2.times { cart.add_item(1) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 7
      expect(cart.items.last.quantity).to be 3
    end

    it "商品可以放到購物車裡，也可以再拿出來" do
      cart.add_item(p1.id)
      expect(cart.items.first.product).to be_a Product
      expect(cart.items.first.product.price).to be 100
    end

    it "可以計算整台購物車的總消費金額。" do
      5.times { cart.add_item(p1.id) }
      3.times { cart.add_item(p2.id) }

      expect(cart.total_price).to be 1100
    end

    it "特別活動可能可搭配折扣(例如聖誕節的時候全面打 9 折，或是滿額滿千送百)" do
      5.times { cart.add_item(p1.id) }
      3.times { cart.add_item(p2.id) }

      Timecop.travel(Time.local(2008, 12, 24, 10, 5, 0))
      expect(cart.total_price).to be 1100

      Timecop.travel(Time.local(2008, 12, 25, 10, 5, 0))
      expect(cart.total_price).to be 1100 * 0.9
    end
  end

  describe "進階功能" do
    it "可以將購物車內容轉換成 Hash" do
      cart = Cart.new
      3.times { cart.add_item(1) }
      5.times { cart.add_item(2) }

      expect(cart.serialize).to eq cart_item_hash
    end

    it "也可以把 Hash 還原成購物車的內容" do
      cart = Cart.from_hash(cart_item_hash)

      expect(cart.items.count).to be 2
      expect(cart.items.first.product_id).to be 1
      expect(cart.items.last.quantity).to be 5
    end
  end

  private
  def cart_item_hash
    {
      "items" => [
        {"product_id" => 1, "quantity" => 3},
        {"product_id" => 2, "quantity" => 5}
      ]
    }
  end
end

