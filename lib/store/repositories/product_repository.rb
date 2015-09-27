module Commerce

  module Store
    class ProductRepository
      include Curator::Repository
      indexed_fields :id, :slug #sku, :product_id
    end
  end
end
