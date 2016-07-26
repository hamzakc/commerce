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
end
