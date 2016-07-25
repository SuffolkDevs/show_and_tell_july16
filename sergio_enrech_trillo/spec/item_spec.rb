require 'item'

describe Item do

  subject(:item) { described_class.new(code: :"001",
    name: "Lavender heart", price: 9.25) }

  context "initalization" do
    it "takes code, name and price paramaters" do
      code = :"001"
      name = "Lavender heart"
      price = 9.25

      expect(item.code).to eq code
      expect(item.name).to eq name
      expect(item.price).to eq price
    end

    it "price can be modified" do
      item.price = 8.50
      expect(item.price).to eq 8.50
    end
  end
end