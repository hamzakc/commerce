module Commerce
  module Store
    class Base < Sinatra::Base
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
    end
  end
end
