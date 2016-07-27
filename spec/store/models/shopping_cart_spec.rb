require_relative '../../spec_helper.rb'

describe Commerce::Store::ShoppingCart do

  context "structure" do
    let (:shopping_cart) {described_class.new}

    it "has all fields" do
      [:id, :expire_time, :items].each { |name| shopping_cart_responds_to(name)}
    end

    def shopping_cart_responds_to(attribute)
      expect(shopping_cart).to respond_to attribute
    end
  end

  context "#add_item" do
    let (:shopping_cart) {described_class.new}

    it "adds a new item" do
      item = {id:'new_id',quantity: '50'}
      shopping_cart.add_item(item)
      expect(shopping_cart.items.first).to eq item
    end

    context "when item exists" do
      let(:items) {[{"id": id,"quantity": 1}]}
      let(:id) {"prod_id"}

      let(:shopping_cart) {described_class.new(id: id,
                                               expire_time: Time.now,
                                               items: items)}

      it "should increment the quantity" do
        shopping_cart.add_item(items.first)
        expect(shopping_cart.items.first[:quantity]).to eq 2
      end

      it "should only have one item" do
        shopping_cart.add_item(items.first)
        expect(shopping_cart.items.size).to eq 1
      end

    end
  end

  context "#add_items" do

    let (:shopping_cart) {described_class.new}

    it "adds a new item" do
      items = [{id:'new_id',quantity: '50'}]
      shopping_cart.add_items(items)
      expect(shopping_cart.items.first).to eq items.first
    end
  end

  context "#remove_item" do
    let(:item_id) {'new_id'}
    let(:item) { {id: item_id, quantity: '50'}}
    let(:shopping_cart) {described_class.new(id: 'one', items: [item])}

    context "when item_id found" do
      it "deletes the item" do
        shopping_cart.remove_item(item_id)
        expect(shopping_cart.items).to be_empty
      end

      it "returns true" do
        expect(shopping_cart.remove_item(item_id)).to be
      end
    end

    context "when item_id is not found" do
      it "does not deletes the item" do
        shopping_cart.remove_item("id_not_found")
        expect(shopping_cart.items).to_not be_empty
      end

      it "returns false" do
        expect(shopping_cart.remove_item("id_not_found")).to_not be
      end
    end

  end

end
