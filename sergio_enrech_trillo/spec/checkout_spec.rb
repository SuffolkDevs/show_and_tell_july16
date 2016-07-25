require 'checkout'

describe Checkout do
  let(:item1) { double(item_code: :"001", name: "Lavender heart", price: 9.25) }
  let(:item2) { double(item_code: :"002", name: "Personalised cufflinks", price: 45) }
  let(:item3) { double(item_code: :"003", name: "Kids T-shirt", price: 19.95) }
  let(:promo_rules) { double}
  let(:basket) { Basket.new }
  subject(:checkout) { described_class.new }

  context "initialization" do
    it "total is zero" do
      expect(checkout.total).to eq "£0.00"
    end
  end

  context "scan" do
    it "scanning an item returns true" do
      expect(checkout.scan(item1)).to eq [item1]
    end

    it "item is added after scanning" do
      checkout.scan(item1)
      expect(checkout.total).to eq "£9.25"
    end
  end

  context "calculates totals, no discount - wip" do
    it "with item1 one basket, total is price of item1" do
      checkout.scan(item1)
      checkout.scan(item2)
      expect(checkout.total).to eq "£54.25"
    end

    it "with item2 in basket, total is price of item2" do
      checkout.scan(item2)
      expect(checkout.total).to eq "£#{format('%.2f',item2.price)}"
    end
  end
end