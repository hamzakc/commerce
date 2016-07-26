require_relative '../spec_helper'
include Commerce::Store
describe Commerce::Store::ShoppingCarts do

  def app
    described_class.new
  end

  let(:item_id) {"item_id"}
  let(:qty) {1}
  let(:id) {'session_id'}
  let(:items) {[{"id": item_id,"quantity": qty}]}
  let(:parsed_response) {CollectionJSON.parse(response.body)}

  let(:cart1) do
    ShoppingCart.new(id: id, expire_time: Time.now, items: items)
  end

  before do
    ShoppingCartRepository.save(cart1)
  end

  describe "#show" do
    context "when id found" do
      let(:response) do
        get "/#{id}"
        last_response
      end

      it "returns the shopping cart" do
        expect(response.body).to_not be_nil
      end

      it "returns collection+json" do
        expect(response.content_type).to eq("application/vnd.collection+json")
      end

      context "values" do
        subject(:item) {parsed_response.items.first}

        it "sets the id" do
          expect(item.datum("id")).to_not be_nil
        end

        it "sets the expire_time" do
          expect(item.datum("expire_time")).to_not be_nil
        end

        it "sets the item fields" do
          %w(id quantity).each do |field|
            expect(item.datum("items").value.first[field]).to_not be_nil
          end
        end
      end
    end
  end

  describe "#update" do

    subject(:item) {parsed_response.items.first}

    let(:response) do
      get "/#{id}"
      last_response
    end

    context "new product" do
      let(:new_product_id) {"new_prod_id"}
      let(:new_product_qty) {"4"}

      before do
        put "/#{id}", item: {id: new_product_id, quantity: new_product_qty}
      end
      it "adds item" do
        expect(item.datum("items").value.size).to eql 2
      end

      it "sets the id" do
        expect(item.datum("items").value.last["id"]).to eq new_product_id
      end

      it "sets the quantity" do
        expect(item.datum("items").value.last["quantity"]).to eq new_product_qty
      end
    end
  end
end
