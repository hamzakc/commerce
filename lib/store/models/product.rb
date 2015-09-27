module Commerce
  module Store
    class Product
      include Curator::Model
      attr_accessor :id, :department, :category, :title, :description, :summary, :main_thumbnail,
        :main_image, :slug

      def self.collection(products: products, url: '/products')
        CollectionJSON.generate_for(url) do |builder|
          Array(products).each do |product|
            builder.add_item("/products/#{product.slug}") do |item|
              item_attributes.each do |attribute|
                item.add_data attribute, value: product.send(attribute)
              end
              item.add_link product.main_thumbnail,"thumbnail", prompt: "Thumbnail of #{product.title}", render: "image"
              item.add_link product.main_image, "image", prompt: "Image of #{product.title}", render: "image"
            end
          end
          builder.set_template do |template|
          end
        end
      end

      private

      def self.item_attributes
        [:id, :department, :category, :title, :description, :summary]
      end

    end
  end
end
