json.extract! product, :id, :model, :description, :production_year, :created_at, :updated_at
json.url product_url(product, format: :json)
