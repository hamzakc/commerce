require_relative '../spec_helper'
include SinatraCommerce::Store
describe SinatraCommerce::Store::Products do

  def app
    described_class.new
  end

  let(:product1) {Product.new(:id => '123', title: 'Test Title', slug: 'prod1')}
  let(:parsed_response) {CollectionJSON.parse(response.body)}

  describe "#show" do
    context "when product id found" do

      subject(:response) do
        ProductRepository.save(product1)
        get "/#{product1.slug}"
        last_response
      end

      it "returns the product" do
        expect(subject.body).to_not be_nil
      end

      it "returns collection+json" do
        expect(subject.content_type).to eq("application/vnd.collection+json")
      end

      context "items" do
        subject(:item) {parsed_response.items.first}

        it "sets the fields" do
          %w(id department category title description summary).each do |field|
            expect(item.datum(field)).to_not be_nil
          end
        end

        it "sets the links" do
          %w(thumbnail image).each do |field|
            expect(item.link(field)).to_not be_nil
          end
        end
      end
    end

    context "when product id not found" do
      subject(:response) do
        get "/non-existent"
        last_response
      end

      it "returns a 404" do
        expect(subject.status).to eq 404
      end
    end
  end

  describe "#index" do

    context "when products are present" do

      subject(:response) do
        get '/'
        last_response
      end

      before(:each) do
        ProductRepository.save(product1)
      end

      it "returns collection+json" do
        expect(subject.content_type).to eq("application/vnd.collection+json")
      end

      context "items" do
        subject(:item) {parsed_response.items.first}

        it "sets the fields" do
          %w(id department category title description summary).each do |field|
            expect(item.datum(field)).to_not be_nil
          end
        end

        it "sets the links" do
          %w(thumbnail image).each do |field|
            expect(item.link(field)).to_not be_nil
          end
        end
      end
    end
  end
end
