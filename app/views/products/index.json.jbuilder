json.array!(@products) do |product|
  json.extract! product, :id, :title, :desc, :image_link
  json.url product_url(product, format: :json)
end
