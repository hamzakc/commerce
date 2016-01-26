module Commerce

  module Store
    class ShoppingCartRepository
      include Curator::Repository
      indexed_fields :id
    end
  end
end
