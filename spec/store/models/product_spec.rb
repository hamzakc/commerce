require_relative '../../spec_helper.rb'

describe Commerce::Store::Product do

  context "structure" do
    let (:product) {described_class.new}

    it "has all fields" do
      [:department, :category, :title, :description, :summary, :main_thumbnail,
        :main_image, :slug, :inventory].each { |name| product_responds_to name}
    end

    def product_responds_to(attribute)
      expect(product).to respond_to attribute
    end

  end
end
