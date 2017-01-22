class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def serial
  	# "00000000#{id}".right(8)
  	"OD#{id.to_s.rjust(8,"0")}" #兩種都可以寫

  end

end
