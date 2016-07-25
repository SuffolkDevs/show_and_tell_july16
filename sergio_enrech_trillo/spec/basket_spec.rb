require 'basket'

describe Basket do

  let(:item1) { Item.new(code: :"001", name: "Lavender heart", price: 9.25) }
  let(:item2) { Item.new(code: :"002", name: "Personalised cufflinks", price: 45) }
  let(:item3) { Item.new(code: :"003", name: "Kids T-shirt", price: 19.95) }
  subject(:basket) { described_class.new() }

  it "on initialization, it is empty" do
    expect(basket).to be_empty
  end

  it "adds an item" do
    basket.add(item1)
    expect(basket.count).to eq 1
  end

  it "calculates sum of items" do
    basket.add(item1)
    basket.add(item2)
    basket.add(item3)
    expect(basket.sum).to eq 74.20
  end

  it "changes the unit cost of a specified item code, for each instance in basket" do
    basket.add(item1)
    basket.add(item2)
    basket.add(item1)
    basket.change_price(:"001", 8.50)
    expect(basket.sum).to eq 62.00
  end

end