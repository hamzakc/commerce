module Commerce
  module Store
    class Base < Sinatra::Base
      configure :test do
        Curator.configure(:resettable_riak) do |config|
          config.bucket_prefix = "curator"
          config.environment = "test"
          config.migrations_path = File.expand_path(File.dirname(__FILE__) + "/db/migrate")
          config.riak_config_file = File.expand_path(File.dirname(__FILE__) + "/config/riak.yml")
        end
      end
      configure :development do
        Curator.configure(:riak) do |config|
          config.bucket_prefix = "curator"
          config.environment = "development"
          config.migrations_path = File.expand_path(File.dirname(__FILE__) + "/db/migrate")
          config.riak_config_file = File.expand_path(File.dirname(__FILE__) + "/config/riak.yml")
        end
      end
    end
  end
end
