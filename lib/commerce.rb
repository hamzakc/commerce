require "rubygems"
require "bundler/setup"
require "sinatra/base"
require "erb"
require "curator"
require 'mongo'
require 'collection-json'

module Commerce
  ROOT = File.expand_path(File.dirname(__FILE__))
  unless $LOAD_PATH.any?{|lp| File.expand_path(lp) == ROOT }
        $LOAD_PATH.unshift(ROOT)
  end

  # Store
  # Store::Product Service
  require 'store/models/product'
  require 'store/repositories/product_repository'
  require 'store/base'
  require 'store/products'
end
