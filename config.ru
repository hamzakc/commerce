require './lib/sinatra_commerce'

run Rack::URLMap.new(
  '/products' => SinatraCommerce::Store::Products
)
