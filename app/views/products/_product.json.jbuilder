# json.extract! product, :id, :title, :description, :price, :created_at, :updated_at
json.extract! product, :id, :title, :description
json.url product_url(product, format: :json)