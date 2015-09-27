require './lib/commerce'

run Rack::URLMap.new(
  '/products' => Commerce::Store::Products
)
