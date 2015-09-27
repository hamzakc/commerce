module Commerce
  module Store
    class Products < Sinatra::Base
      #TODO: Move to module
      configure :test do
        Curator.configure(:mongo) do |config|
          config.environment = "test"
          config.database = "product_store_test"
          config.mongo_config_file = File.expand_path(File.dirname(__FILE__) + "/config/mongo.yml")
          config.migrations_path   = File.expand_path(File.dirname(__FILE__) + "/db/migrate")
        end
      end
      configure :development do
        Curator.configure(:mongo) do |config|
          config.environment = "development"
          config.database = "product_store_dev"
          config.mongo_config_file = File.expand_path(File.dirname(__FILE__) + "/config/mongo.yml")
          config.migrations_path   = File.expand_path(File.dirname(__FILE__) + "/db/migrate")
        end
      end

      # Get all products
      get '/' do
        #TODO: Put pagination
        products = ProductRepository.all
        content_type "application/vnd.collection+json"
        Product.collection(products: products).to_json
      end

      # Get single product
      get '/:slug' do
        product = ProductRepository.find_first_by_slug params[:slug]
        if product
          content_type "application/vnd.collection+json"
          Product.collection(products: product, url: "/#{product.slug}").to_json
        else
          halt(404)
        end
      end

      # Get all products in categories
      get '/c/*' do
        if params[:splat].any?
          # Look up the categories
          products = ProductRepository.find_by_category(params[:splat].first)
          if products.any?
            content_type "application/vnd.collection+json"
            Product.collection(products: products, url: "/c/#{params[:splat].first}").to_json
          else
            halt(404)
          end
        end
      end
    end
  end
end
