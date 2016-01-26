module Commerce

  module Store
    class InventoryRepository
      include Curator::Repository
      indexed_fields :id
    end
  end
end
