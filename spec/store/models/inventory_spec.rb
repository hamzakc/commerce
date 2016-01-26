require_relative '../../spec_helper.rb'

describe Commerce::Store::Inventory do

  context "structure" do
    let (:inventory) {described_class.new}

    it "has all fields" do
      [:id, :sku, :color, :size, :returnable, :price, :remaining, :tax, :tax_title].each { |name| inventory_responds_to(name)}
    end

    def inventory_responds_to(attribute)
      expect(inventory).to respond_to attribute
    end

  end

end
