module Commerce

  module Store
    class ProductRepository
      include Curator::Repository
      indexed_fields :id, :slug, :category, :department #sku, :product_id
    end
  end
end
