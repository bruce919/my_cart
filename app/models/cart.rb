class Cart
  attr_reader :items
  def initialize(items = [])
    @items = items
  end

  def empty?
    items.empty?
  end

  def add_item(product_id)
    found_item = items.find { |item| item.product_id == product_id }

    if found_item
      found_item.increment
    else
      items << CartItem.new(product_id)
    end
  end

  def total_price
    total = items.reduce(0) { |sum, item| sum + item.price }

    if xmas
      total * 0.9
    else
      total
    end
  end

  def serialize
    result = items.map { |item| {"product_id" => item.product_id, "quantity" => item.quantity} }

    { "items" => result }
  end

  def self.from_hash(hash)
    if hash && hash["items"]
      new hash["items"].map { |item_hash|
        CartItem.new(item_hash["product_id"], item_hash["quantity"])
      }
    else
      new
    end
  end

  private
  def xmas
    Date.today.month == 12 && Date.today.day == 25
  end
end

