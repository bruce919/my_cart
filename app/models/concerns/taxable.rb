module Taxable
  extend ActiveSupport::Concern

  included do
  end

  def total_price_without_tax
    (total_price / 1.05).round
  end

  def tax
    (total_price - (total_price / 1.05)).round
  end

  class_methods do
    def hello
    end
  end
end
