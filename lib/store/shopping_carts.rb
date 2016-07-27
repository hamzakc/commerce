module Commerce
  module Store
    class ShoppingCarts < Commerce::Store::Base

      get '/:id' do
        render_collection(find_shopping_cart)
      end

      post '/:id' do
        shopping_cart = ShoppingCart.new(id: params[:id],expire_time: Time.now + 86400)
        shopping_cart.add_items(params[:items])
        ShoppingCartRepository.save(shopping_cart)

        render_collection(shopping_cart)
      end

      put '/:id' do
        shopping_cart = find_shopping_cart
        shopping_cart.add_item(params[:item])
        ShoppingCartRepository.save(shopping_cart)
        render_collection(shopping_cart)
      end

      delete '/:id/:item_id' do
        shopping_cart = find_shopping_cart
        shopping_cart.remove_item(params[:item_id])
        ShoppingCartRepository.save(shopping_cart)
        render_collection(shopping_cart)
      end

      private

      def render_collection(shopping_cart)
        content_type "application/vnd.collection+json"
        ShoppingCart.collection(shopping_cart: shopping_cart, url: "/cart").to_json
      end

      def find_shopping_cart
        shopping_cart = ShoppingCartRepository.find_first_by_id(params[:id])
        if !shopping_cart
          halt(404)
        else
          shopping_cart
        end
      end

    end
  end
end
