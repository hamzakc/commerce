module Commerce
  module Store
    class ShoppingCart
      include Curator::Model
      attr_accessor :id, :user, :expire_time, :items

      def self.collection(shopping_cart:, url: '/cart')
        CollectionJSON.generate_for(url) do |builder|
          Array(shopping_cart).each do |_cart|
            builder.add_item("/shipping_cart/#{_cart.id}") do |item|
              item_attributes.each do |attribute|
                item.add_data attribute, value: _inventory.send(attribute)
              end
            end
          end
          builder.set_template do |template|
          end
        end
      end

      private

      def self.item_attributes
        [:id, :expire_time, :items]
      end
    end
  end
end

