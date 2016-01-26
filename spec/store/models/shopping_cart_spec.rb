require_relative '../../spec_helper.rb'

describe Commerce::Store::ShoppingCart do

  context "structure" do
    let (:shopping_cart) {described_class.new}

    it "has all fields" do
      [:id, :user, :expire_time, :items].each { |name| shopping_cart_responds_to(name)}
    end

    def shopping_cart_responds_to(attribute)
      expect(shopping_cart).to respond_to attribute
    end
  end
end
