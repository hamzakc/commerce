module Commerce
  module Store
    class Inventories < Commerce::Store::Base

      # Get inventory
      get '/:id' do
        unless params[:id].nil?
          inventory_item = InventoryRepository.find_first_by_id(params[:id])
          if inventory_item
            content_type "application/vnd.collection+json"
            Inventory.collection(inventory: inventory_item, url: "/inventories").to_json
          else
            halt(404)
          end
        end
      end
    end
  end
end
