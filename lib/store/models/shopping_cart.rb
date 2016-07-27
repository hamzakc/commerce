module Commerce
  module Store
    class ShoppingCart
      include Curator::Model
      attr_accessor :id, :expire_time, :items

      def self.collection(shopping_cart:, url: '/cart')
        CollectionJSON.generate_for(url) do |builder|
          Array(shopping_cart).each do |_cart|
            builder.add_item("/shopping_cart/#{_cart.id}") do |item|
              item_attributes.each do |attribute|
                item.add_data attribute, value: _cart.send(attribute)
              end
            end
          end
          builder.set_template do |template|
          end
        end
      end

      #TODO Refactor
      def add_item(item)
        if items.nil?
          self.items = [item]
        else
          items.each do |existing_item|
            if existing_item[:id] == item[:id]
              existing_item[:quantity] = existing_item[:quantity].to_i + 1
              return
            end
          end
          self.items << item
        end
      end

      def add_items(items)
        items.each {|item| add_item(item)}
      end

      def remove_item(item_id)
        items.each_with_index do |existing_item,index|
          if existing_item[:id] == item_id
            items.delete_at(index)
            return true
          end
        end
        false
      end

      private
      def self.item_attributes
        [:id, :expire_time, :items]
      end
    end
  end
end
