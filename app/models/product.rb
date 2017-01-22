class Product < ApplicationRecord
	acts_as_paranoid
  has_many :order_items
end
