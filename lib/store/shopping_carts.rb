module Commerce
  module Store
    class ShoppingCarts < Commerce::Store::Base
      get '/:id' do
        unless params[:id].nil?
          shopping_cart = ShoppingCartRepository.find_first_by_id(params[:id])
          if shopping_cart
            content_type "application/vnd.collection+json"
            ShoppingCart.collection(shopping_cart: shopping_cart, url: "/cart").to_json
          else
            halt(404)
          end
        end
      end

      put '/:id' do
        unless params[:id].nil?
          shopping_cart = ShoppingCartRepository.find_first_by_id(params[:id])
          if shopping_cart
            shopping_cart.add_item(params[:item])
            ShoppingCartRepository.save(shopping_cart)

            content_type "application/vnd.collection+json"
            ShoppingCart.collection(shopping_cart: shopping_cart, url: "/cart").to_json
          else
            halt(404)
          end
        end
      end
    end
  end
end
