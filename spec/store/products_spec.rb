require_relative '../spec_helper'
include Commerce::Store
describe Commerce::Store::Products do

  def app
    described_class.new
  end
  let(:category) {"Shoes/Women/Pumps"}
  let(:product1) {Product.new(:id => '123', title: 'Test Title', slug: 'prod1', category: category)}
  let(:parsed_response) {CollectionJSON.parse(response.body)}

  before do
    ProductRepository.save(product1)
  end

  describe "#show" do
    context "when product id found" do

      let(:response) do
        get "/#{product1.slug}"
        last_response
      end

      it "returns the product" do
        expect(response.body).to_not be_nil
      end

      it "returns collection+json" do
        expect(response.content_type).to eq("application/vnd.collection+json")
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
      let(:response) do
        get "/non-existent"
        last_response
      end

      it "returns a 404" do
        expect(response.status).to eq 404
      end
    end
  end

  describe "#index" do

    context "when products are present" do

      let(:response) do
        get '/'
        last_response
      end

      it "returns collection+json" do
        expect(response.content_type).to eq("application/vnd.collection+json")
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

  describe "category lookup" do

    context "category exists" do

      let(:response) do
        get "/c/#{category}"
        last_response
      end

      it "returns collection+json" do
        expect(response.content_type).to eq("application/vnd.collection+json")
      end

      it "finds product1" do
        expect(parsed_response.items).to_not be_empty
      end

      it "sets the correct url" do
        expect(parsed_response.href).to eq "/c/#{category}"
      end

    end

    context "category does not exist" do

      let(:response) do
        get "/c/made-up-cat"
        last_response
      end

      it "renders 404" do
        expect(response.status).to eq 404
      end

    end

  end

end
