require_relative '../spec_helper'
include Commerce::Store
describe Commerce::Store::Inventories do

  def app
    described_class.new
  end

  let(:inventory1) {Inventory.new(id: '123', sku: 'HJK', color: 'red', size: 'L',
                                 returnable: 'true', price: '100', remaining: '10',
                                 tax: '20', tax_title: 'VAT'
                                 )}

  let(:parsed_response) {CollectionJSON.parse(response.body)}

  before do
    InventoryRepository.save(inventory1)
  end

  describe "#show" do
    context "when inventory id found" do

      let(:response) do
        get "/#{inventory1.id}"
        last_response
      end

      it "returns the inventory item" do
        expect(response.body).to_not be_nil
      end

      it "returns collection+json" do
        expect(response.content_type).to eq("application/vnd.collection+json")
      end

      context "items" do
        subject(:item) {parsed_response.items.first}

        it "sets the fields" do
          %w(id sku color size returnable price remaining tax tax_title).each do |field|
            expect(item.datum(field)).to_not be_nil
          end
        end
      end
    end

    context "when product id not found" do
      let(:response) do
        get "/non-existent"
        last_response
      end

      it "returns a 404" do
        expect(response.status).to eq 404
      end
    end
  end
end
