require "rubygems"
require "bundler/setup"
require "sinatra/base"
require "erb"
require "curator"
require 'riak'
require 'collection-json'

module Commerce
  ROOT = File.expand_path(File.dirname(__FILE__))
  unless $LOAD_PATH.any?{|lp| File.expand_path(lp) == ROOT }
        $LOAD_PATH.unshift(ROOT)
  end

  # Store
  # Store::Product Service
  require 'store/models/product'
  require 'store/models/inventory'
  require 'store/models/shopping_cart'
  require 'store/repositories/product_repository'
  require 'store/repositories/inventory_repository'
  require 'store/repositories/shopping_cart_repository'
  require 'store/base'
  require 'store/products'
  require 'store/inventories'
end
