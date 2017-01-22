class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items




  include AASM
  aasm do
    state :pending, initial: true
    state :paid, :shipped, :delivered, :cancelled

    event :pay do
      transitions from: :pending, to: :paid

      after do
        # 發送簡訊
      end
    end

    event :ship do
      transitions from: :paid, to: :shipped

      after do
        # 發送 line 訊息
        puts "心存善念"
      end
    end

    event :deliver do
      transitions from: :shipped, to: :delivered
    end

    event :cancel do
      transitions from: [:pending, :delivered], to: :cancelled
    end
  end  

  def total_price
  	order_items.reduce(0) { |sum, item| sum + item.price }
  end

  
  def serial
  	# "00000000#{id}".right(8)
  	"OD#{id.to_s.rjust(8,"0")}" #兩種都可以寫

  end

end
