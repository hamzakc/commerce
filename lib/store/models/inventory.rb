module Commerce
  module Store
    class Inventory
      include Curator::Model
      attr_accessor :id, :sku, :color, :size, :returnable, :price, :remaining, :tax, :tax_title

      def self.collection(inventory:, url: '/products')
        CollectionJSON.generate_for(url) do |builder|
          Array(inventory).each do |_inventory|
            builder.add_item("/inventory_link/#{_inventory.id}") do |item|
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
        [:id, :sku, :color, :size, :returnable, :price, :remaining, :tax, :tax_title]
      end
    end
  end
end

